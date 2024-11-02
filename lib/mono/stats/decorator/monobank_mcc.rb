# frozen_string_literal: true

module Mono
  module Stats
    module Decorator
      class MonobankMcc < Monobank
        def initialize(item:)
          super(item:)

          @mcc_groups = JSON.parse(File.read('lib/mcc/mcc.json'))
          @mcc = JSON.parse(File.read('lib/mcc/mcc-uk.json'))
        end

        def category
          item['mcc']
        end
      end
    end
  end
end
