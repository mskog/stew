module Stew
  module Store
    class AppOffers
      include Enumerable

      def initialize(node)
        @app_offers = node.css("div.game_area_purchase_game").map {|item| AppOffer.create(item)}
      end

      def each(&block)
        @app_offers.each {|item| yield item}
      end

      def sale?
        sales.count != 0
      end

      def sales
        @app_offers.select {|item| item.sale?}
      end
    end
  end
end