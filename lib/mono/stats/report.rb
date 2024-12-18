# frozen_string_literal: true

require 'fileutils'
require 'date'
require 'json'

module Mono
  module Stats
    class Report
      attr_reader :downloader, :year, :analyzer

      def initialize(downloader:, analyzer:, year:)
        @downloader = downloader
        @year = year
        @analyzer = analyzer
      end

      def build_csv
        csv = ";;#{columns.join(';')}"

        body = report.each_with_object([]) do |pair, result|
          category = pair.first

          pair.last.each do |sub_pair|
            subcategory = sub_pair.first
            sub_result = [category, subcategory]
            deb_result = []
            cred_result = []
            columns = sub_pair.last
            columns.each_value do |value|
              deb_result << value['deb']
              cred_result << value['cred']
            end
            result << (sub_result + deb_result) if deb_result.uniq != [0.0]
            result << (sub_result + cred_result) if cred_result.uniq != [0.0]
          end
        end

        body = Mono::Stats::Sorter.sort(body)

        "#{csv}\n#{body.map { |row| row.join(';') }.join("\n")}"
      end

      def export_to_csv(filename:)
        FileUtils.mkdir_p(File.dirname(filename))
        File.write(filename, build_csv)
      end

      private

      def download
        (1..12).each_with_object([]) do |month, result|
          from = DateTime.new(year, month, 1, 0, 0, 0)
          to = DateTime.new(year, month, Date.new(year, month, -1).day, 23, 59, 59)

          puts "Fetching data for #{year} #{month}"
          result << downloader.fetch(from:, to:)
        end.flatten
      end

      def report
        @report ||= analyzer.analyze(statements: download, columns:)
      end

      def columns
        %w[
          01
          02
          03
          04
          05
          06
          07
          08
          09
          10
          11
          12
        ]
      end
    end
  end
end
