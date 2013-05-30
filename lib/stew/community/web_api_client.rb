module Stew
  module Community
    class WebApiClient
      BASE_URI = 'http://api.steampowered.com'

      def initialize(client = WebClient.new(BASE_URI), opts={})
        @api_key = opts[:steam_api_key] || Stew.config[:steam_api_key]
        @client = client
      end

      def vanity_url_to_steam_id(vanity_url)
        vanity_name = vanity_url.split('/').last
        @client.get("/ISteamUser/ResolveVanityURL/v0001/?key=#{@api_key}&vanityurl=#{vanity_name}")['response']['steamid'].to_i
      end

      def profile(steam_id)
        response = @client.get("/ISteamUser/GetPlayerSummaries/v0002/?key=#{@api_key}&steamids=#{steam_id}")['response']['players']
        raise ProfileNotFoundError if response.empty?
        raise PrivateProfileError if response.first['communityvisibilitystate'] == 1
        response.first
      end

      def profile_games(steam_id)
        begin
          response = @client.get("/IPlayerService/GetOwnedGames/v0001/?key=#{@api_key}&steamid=#{steam_id}&include_appinfo=1")
          raise PrivateProfileError if response['response'].empty?
          response['response']['games']
        rescue Stew::Community::WebClientError
          raise ProfileNotFoundError
        end
      end

      def profile_friends(steam_id)
        begin
          response = @client.get("/ISteamUser/GetFriendList/v0001/?key=#{@api_key}&steamid=#{steam_id}&relationship=friend")
          raise PrivateProfileError if response.empty?
          response['friendslist']['friends']
        rescue Stew::Community::WebClientError
          raise ProfileNotFoundError
        end
      end
    end

    class ProfileNotFoundError < StandardError; end

    class PrivateProfileError < StandardError; end
  end
end