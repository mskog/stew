module Stew
  module Community
    class WebApiClient
      BASE_URI = 'http://api.steampowered.com'

      def initialize(api_key, client = WebClient.new(BASE_URI))
        @api_key = api_key
        @client = client
      end

      def profile(steam_id)
        @client.get("/ISteamUser/GetPlayerSummaries/v0002/?key=#{@api_key}&steamids=#{steam_id}")['response']['players'].first
      end
    end
  end
end