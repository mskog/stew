module Stew
  class CommunityClient
    COMMUNITY_URL = 'http://steamcommunity.com'

    # Converts a steam vanity name into a 64-bit steam id
    # @example Convert a vanity name
    #   Stew::CommunityClient.steam_id_from_vanity_name("eekon20") #=> 76561197986383225
    # 
    # @param [String] name the vanity name
    # @return [Integer] the 64-bit steam id
    def self.steam_id_from_vanity_name(name)
      Stew::XmlClient.new(COMMUNITY_URL).get("/id/#{name}")['profile']['steamID64'].to_i
    end
 
    # @option opts [String] :client (Stew::XmlClient) The xml client this instance should use
    # @option opts [String] :base_path ("profiles") The xml client this instance should use
    def initialize(opts = {})
      @xml_client = opts[:client] || Stew.config[:default_xml_client].new(COMMUNITY_URL)
      @base_path = opts[:base_path] || 'profiles'
    end

    # Creates a new Community::Profile instance for the given Steam id
    # 
    # @param [Integer] id The 64 bit Steam id
    # @return [Profile]
    def profile(id)
      Community::Profile.new @xml_client.get(path(id))['profile']
    end

    # Creates a new Community::ProfileGames instance for the given Steam id
    # 
    # @param [Integer] id The 64 bit Steam id
    # @return [ProfileGames]
    def profile_games(id)
      Community::ProfileGames.new @xml_client.get(path(id,'games'))['gamesList']['games']['game']
    end

    # Creates a new Community::ProfileFriends instance for the given Steam id
    # 
    # @param [Integer] id The 64 bit Steam id
    # @return [ProfileFriends]
    def profile_friends(id)
      Community::ProfileFriends.new @xml_client.get(path(id,'friends'))['friendsList']['friends']['friend']
    end

    private

    def path(id,command='')
      "/#{@base_path}/#{id}/#{command}"
    end
  end
end