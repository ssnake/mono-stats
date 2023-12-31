# frozen_string_literal: true

require_relative 'decorator/monobank'

module Mono
  module Stats
    class Analyzer
      def initialize(statements:)
        @statements = statements
      end

      def analyze(columns:)
        @statements.each_with_object({}) do |item, result|
          next if item.nil?

          statement = Decorator::Monobank.new(item:)

          next unless columns.include?(statement.column)

          result[statement.category] ||= {}
          result[statement.category][statement.subcategory] ||= {}
          subcategory = result[statement.category][statement.subcategory]

          columns.each do |column|
            subcategory[column] ||= { 'deb' => 0.0, 'cred' => 0.0 }
          end

          if statement.amount > 0.0
            subcategory[statement.column]['deb'] += statement.amount
          else
            subcategory[statement.column]['cred'] += statement.amount
          end
        rescue StandardError => e
          puts "#{e.message}\nItem caused error:\n#{item.inspect}"
        end
      end
    end
  end
end
