# frozen_string_literal: true

require 'fileutils'
require 'date'
require 'json'

module Mono
  module Stats
    class Report
      attr_reader :downloader, :year

      def initialize(downloader:, year:)
        @downloader = downloader
        @year = year
      end

      def download
        (1..12).each_with_object([]) do |month, result|
          from = DateTime.new(year, month, 1, 0, 0, 0)
          to = DateTime.new(year, month, Date.new(year, month, -1).day, 23, 59, 59)

          puts "Fetching data for #{year} #{month}"
          result << downloader.fetch(from:, to:)
        end.flatten
      end
      
      def build_csv
        report = Analyzer
          .new(statements: download)
          .analyze(columns: [
            "01", 
            "02", 
            "03", 
            "04", 
            "05", 
            "06", 
            "07", 
            "08", 
            "09", 
            "10", 
            "11", 
            "12"]
          )

        report.each_with_object([]) do |pair, result|
          row = [pair.first]
          pair.last.each do |column, value|
            row << value
          end
          result << row.join(";")
        end.join("\n")
      end

      def export_to_csv(filename:)
        FileUtils.mkdir_p(File.dirname(filename))
        File.write(filename, build_csv)
      end
    end
  end
end
  