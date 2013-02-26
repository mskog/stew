module Stew
  module Store
    class Sale
      def initialize(node)
        @node = node
      end

      def name
        @node.at_css("div.tab_desc").xpath("//h4").first.content
      end

      def price
        Stew.money @node.at_css("div.tab_price").children.last.content.strip
      end

      def original_price
        Stew.money @node.at_css("div.tab_price").xpath("//strike").first.content.strip
      end

      def app_id
        @node.to_s.match(/tab_row_Discounts_([0-9]+)/)[1].to_i
      end
    end
  end
end