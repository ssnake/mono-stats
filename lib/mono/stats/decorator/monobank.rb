# frozen_string_literal: true

module Mono
  module Stats
    module Decorator
      class Monobank
        attr_reader :item

        def initialize(item:)
          @item = item
        end

        def column
          '%02d' % Time.at(item['time']).month
        end

        def subcategory
          mcc_map[item['mcc']] || item['description'] || item['mcc']
        end

        def amount
          item['amount'] / 100.0
        end

        def category
          item['mcc']
        end

        def mcc_map
          {
            5411 =>	'Продукты',
            5814 => 'Кафе',
            5541 => 'Заправка',
            5912 => 'Аптеки',
            5812 => 'Кафе',
            5655 => 'Одежда',
            5533 => 'Покупки',
            5921 => 'Пиво',
            5499 => 'Продукты',
            9311 => 'Налог',
            8999 => 'Novapay',
            5699 => 'Одежда',
            8011 => 'Медецина',
            5815 => 'Подписки',
            4900 => 'комуналка',
            5722 => 'Покупки',
            5211 => 'Покупки',
            4814 => 'Подписки',
            4121 => 'Такси',
            7922 => 'Развлечение',
            6538 => 'Покупки',
            6011 => 'Наличка',
            7394 => 'Покупки',
            6010 => 'Наличка',
            4816 => 'Paypal'
          }
        end
      end
    end
  end
end
