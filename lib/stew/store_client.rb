module Stew
  class StoreClient
    STORE_URL = 'http://store.steampowered.com'

    def initialize(opts = {})
      @client = opts[:client] || WebClient.new(STORE_URL)
    end

    def create_app(data)
      return app(data) if data.class == Fixnum
      return app($1,$2.to_sym) if data =~ /store.steampowered.com\/app\/([0-9]+)\/?\?cc=([a-zA-Z]{2})/
      return app($1) if data =~ /store.steampowered.com\/app\/([0-9]+)/
      raise AppIdNotFoundError
    end

    def app(id,region = :us)
      Store::App.new(@client.get("/app/#{id}",:cc => region))
    end
  end
  class AppIdNotFoundError < StandardError; end
end