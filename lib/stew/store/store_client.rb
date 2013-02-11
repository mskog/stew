module Stew
  module Store
    # Creation of app objects from URLs or app_ids
    # 
    # Can create apps for any steam region. When no region is given, it defaults to the default region in the configuration
    # 
    # @example Creation of a Stew::Store::App from a URL
    #   Stew::StoreClient.new.create_app('http://store.steampowered.com/app/211420') #=> Stew::StoreClient::App
    # 
    # @example Creation of a Stew::Store::App from an id
    #   Stew::StoreClient.new.create_app(211420) #=> Stew::StoreClient::App
    # 
    # @example Creation of a Stew::Store::App from a URL with a different region
    #   Stew::StoreClient.new.create_app('http://store.steampowered.com/app/211420?cc=uk') #=> Stew::StoreClient::App
    # 
    # @example Creation of a Stew::Store::App from an id and a region
    #   Stew::StoreClient.new.app(211420, :uk) #=> Stew::StoreClient::App
    # 
    class StoreClient
      STORE_URL = 'http://store.steampowered.com'

      def initialize(opts = {})
        @client = opts[:client] || Stew.config[:default_web_client].new(STORE_URL)
      end

      def create_app(data)
        return app(data) if data.class == Fixnum
        return app($1,$2) if data =~ /store.steampowered.com\/app\/([0-9]+)\/?\?cc=([a-zA-Z]{2})/
        return app($1) if data =~ /store.steampowered.com\/app\/([0-9]+)/
        raise AppIdNotFoundError
      end

      def app(app_id,region = Stew.config[:default_region])
        Store::App.new(@client.get("/app/#{app_id}",:cc => region.to_sym))
      end
    end

    # Error used when an app cannot be found
    class AppIdNotFoundError < StandardError; end
  end
end