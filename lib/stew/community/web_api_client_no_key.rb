module Stew
  module Community
    class WebApiClientNoKey
      BASE_URI = 'http://api.steampowered.com'

      def initialize(client = WebClient.new(BASE_URI), opts={})
        @client = client
      end
      
      def number_of_current_players(app_id)
        response = @client.get("/ISteamUserStats/GetNumberOfCurrentPlayers/v1?appid=#{app_id}")
        response['response']['player_count']
      end
    end
  end
end