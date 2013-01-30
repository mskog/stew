module Stew
  module Store
    module Offer
      def description
        description_empty? ? nil : node.at_css('p').content
      end

      def name
        node.at_css('h1').content.strip.gsub('Buy ','')
      end

      def description_empty?
        node.css('p').empty?
      end
    end
  end
end