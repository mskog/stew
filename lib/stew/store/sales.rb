module Stew
  module Store

    # The current Steam Sales
    class Sales
      include Enumerable

      def initialize(response)
        @document = Nokogiri::HTML(response)
        @sales = @document.css('div.tab_row').map{|node| Sale.new(node)}
      end

      def each(&block)
        @sales.each {|sale| yield sale}
      end
    end
  end
end