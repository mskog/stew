module Stew
  module Store
    class AppOffer
      include Offer

      def initialize(node)
        @node = node
      end

      def price
        Stew.money node.at_css('div.game_purchase_price').content.gsub(/[\n\t\r\s]/, '')
      end

      private

      def node
        @node
      end
    end
  end
end