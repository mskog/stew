#encoding: utf-8

module Stew
  module Store
    class AppOffer
      def initialize(node)
        @node = node
      end

      def self.money(price)
        if price.include?("€")
          Money.parse(price[-1,1]+price[0..-2])
        else
          Money.parse price
        end
      end

      def description
        description_empty? ? nil : @node.css('p').first.content
      end

      def name
        @node.css('h1').first.content.strip.gsub('Buy ','')
      end

      def price
        self.class.money @node.css('div.game_purchase_price').first.content.gsub(/[\n\t\r\s]/, '')
      end

      def description_empty?
        @node.css('p').empty?
      end
    end
  end
end