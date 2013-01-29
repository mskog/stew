module Stew
  class CommunityClient
    COMMUNITY_URL = 'http://steamcommunity.com'

    def self.steam_id_from_vanity_name(name)
      Stew::XmlClient.new(COMMUNITY_URL).get("/id/#{name}")['profile']['steamID64']
    end

    def initialize(opts = {})
      @xml_client = opts[:client] || Stew.config[:default_xml_client].new(COMMUNITY_URL)
      @base_path = opts[:base_path] || 'profiles'
    end

    def profile(id)
      Community::Profile.new @xml_client.get(path(id))['profile']
    end

    def profile_games(id)
      Community::ProfileGames.new @xml_client.get(path(id,'games'))['gamesList']['games']['game']
    end

    def profile_friends(id)
      Community::ProfileFriends.new @xml_client.get(path(id,'friends'))['friendsList']['friends']['friend']
    end

    private

    def path(id,command='')
      "/#{@base_path}/#{id}/#{command}"
    end
  end
end