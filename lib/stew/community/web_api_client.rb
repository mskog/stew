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

      def profile_games(steam_id)
        @client.get("/IPlayerService/GetOwnedGames/v0001/?key=#{@api_key}&steamid=#{steam_id}&include_appinfo=1")['response']['games']
      end
    end
  end
end