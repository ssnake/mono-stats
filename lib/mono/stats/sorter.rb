# frozen_string_literal: true

module Mono
  module Stats
    class Sorter
      def self.sort(array)
        categories = array.map { |item| item[0].to_s }.uniq
        result = categories.each_with_object({}) do |category, result|
          only_one_category = array.select { |item| item[0].to_s == category }

          result[category] = only_one_category.map { |item_array| item_array[2..].sum }.sum
        end
        array.sort_by { |item| result[item[0].to_s] }
      end
    end
  end
end
