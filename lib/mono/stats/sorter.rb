# frozen_string_literal: true

module Mono
  module Stats
    class Sorter
      def self.sort(array)
        array.sort_by { |item| item.last(12).sum }
      end
    end
  end
end
