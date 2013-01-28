module Stew
  class StoreClient
    STORE_URL = 'http://store.steampowered.com'

    def initialize(region = :us, client = WebClient.new(STORE_URL))
      @client = client
      @region = region
    end

    def app(id)
      @client.get("/app/#{id}",{:cc => @region})
    end
  end
end