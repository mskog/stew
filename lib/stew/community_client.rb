module Stew
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

    def self.steam_id_from_vanity_name(vanity_name)
      Stew::XmlClient.new(COMMUNITY_URL).get("/id/#{vanity_name}")['profile']['steamID64'].to_i
    end
 
    def initialize(opts = {})
      @xml_client = opts[:client] || Stew.config[:default_xml_client].new(COMMUNITY_URL)
      @base_path = opts[:base_path] || DEFAULT_BASE_PATH
    end

    def profile(steam_id)
      Community::Profile.new @xml_client.get(path(steam_id)).profile
    end

    def profile_games(steam_id)
      Community::ProfileGames.new @xml_client.get(path(steam_id,'games')).games
    end

    def profile_friends(steam_id)
      Community::ProfileFriends.new @xml_client.get(path(steam_id,'friends')).friends
    end

    private

    def path(steam_id,command=nil)
      "/#{@base_path}/#{steam_id}/#{command}"
    end
  end
end