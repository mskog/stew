module Stew
  module Store

    #An app offer that is a sale
    class AppOfferSale < AppOffer
      def price
        Stew.money @node.at_css('div.discount_final_price').content.gsub(/[\n\t\r\s]/, '')
      end

      def regular_price
        Stew.money @node.at_css('div.discount_original_price').content.gsub(/[\n\t\r\s]/, '')
      end

      def sale?
        true
      end

      def description
        nil
      end
    end
  end
end