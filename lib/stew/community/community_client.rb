module Stew
  module Community
    # Creation of all profile* objects.
    # Uses a given or default XmlClient instance to communicate with the Steam API
    # The main identifier for most methods is the 64-bit steam id
    # @example Create a Profile
    #   Stew::CommunityClient.new.profile(76561197992917668) #=> Stew::Community::Profile
    # 
    # @example Resolve a Steam Vanity name
    #   Stew::CommunityClient.steam_id_from_vanity_name('eekon20') #=> 76561197986383225
    #
    class CommunityClient
      COMMUNITY_URL = 'http://steamcommunity.com'
      DEFAULT_BASE_PATH = 'profiles'

      # @deprecated Use CommunityClient.new.steam_id_from_vanity_name instead
      def self.steam_id_from_vanity_name(vanity_name)
        self.new.steam_id_from_vanity_name(vanity_name)
      end
   
      def initialize(opts = {})
        @xml_client = opts[:client] || Stew.config[:default_xml_client].new(COMMUNITY_URL)
        @base_path = opts[:base_path] || DEFAULT_BASE_PATH
      end

      def steam_id_from_vanity_name(vanity_name)
        response = XmlClientResponseProfile.new(@xml_client.get("/id/#{vanity_name}"))
        response.profile['steamID64'].to_i
      end

      def profile(steam_id)
        response = XmlClientResponseProfile.new(@xml_client.get(path(steam_id)))
        Community::Profile.new(response.profile)
      end

      def profile_games(steam_id)
        response = XmlClientResponseGames.new(@xml_client.get(path(steam_id,'games')))
        Community::ProfileGames.new(response.games)
      end

      def profile_friends(steam_id)
        response = XmlClientResponseFriends.new(@xml_client.get(path(steam_id,'friends')))
        Community::ProfileFriends.new(response.friends)
      end

      private

      def path(steam_id,command=nil)
        "/#{@base_path}/#{steam_id}/#{command}"
      end
    end
  end
end