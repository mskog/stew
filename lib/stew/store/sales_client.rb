module Stew
  module Store
    # Creation of sales objects
    class SalesClient
      STORE_URL = 'http://store.steampowered.com'

      def initialize(opts = {})
        @client = opts[:client] || Stew.config[:default_web_client].new(STORE_URL)
      end

      def sales
        Sales.new(@client.get("/search/tab",{:cc => :se, :l => 'english', :tab => 'Discounts', :start => 0, :count => 10000}))
      end
    end

  end
end