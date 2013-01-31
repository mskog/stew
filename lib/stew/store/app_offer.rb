module Stew
  module Store
    class AppOffer
      def self.create(node)
        return AppOfferSale.new(node) unless node.at_css('div.discount_final_price').nil?
        return AppOffer.new(node)
      end

      def initialize(node)
        @node = node
      end

      def price
        Stew.money @node.at_css('div.game_purchase_price').content.gsub(/[\n\t\r\s]/, '')
      end

      def sale?
        false
      end

      def description
        description_empty? ? nil : @node.at_css('p').content
      end

      def name
        @node.at_css('h1').content.strip.gsub('Buy ','')
      end

      private

      def description_empty?
        @node.css('p').empty?
      end
    end
  end
end