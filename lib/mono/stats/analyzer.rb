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

          result[statement.category] ||= {}
          
          columns.each do |column|
            result[statement.category][column] = 0.0 if result[statement.category][column].nil?
          end
          
          result[statement.category][statement.column] = 0.0 if  result[statement.category][statement.column].nil?

          result[statement.category][statement.column] += statement.amount
        rescue StandardError => e
          puts "#{e.message}\nItem caused error:\n#{item.inspect}"
        end
      end
    end
  end
end
    