# frozen_string_literal: true

module Mono
  module Stats
    module Decorator
      class MonobankMcc < Monobank
        attr_reader :mcc_groups, :mcc, :category_cache

        def initialize(item:)
          super(item:)

          @mcc_groups = JSON.parse(File.read('lib/mcc/mcc.json'))
          @mcc = JSON.parse(File.read('lib/mcc/mcc-uk.json'))
          @category_cache = {}
        end

        def category
          return category_cache[item['mcc']] if category_cache[item['mcc']]

          category_cache[item['mcc']] =
            mcc
            .select { |group| group['mcc'].to_i == item['mcc'].to_i }
            &.first&.[]('shortDescription') || item['mcc']
        end
      end
    end
  end
end
