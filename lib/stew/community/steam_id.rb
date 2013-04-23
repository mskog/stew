module Stew
  module Community

    # The base class for all Steam Ids. Has accessors for the base profile, games and friends of a Steam Id
    # 
    # @example Create an instance from a 64-bit steam id
    #   Stew::Community::SteamId.new(76561197992917668) #=> Stew::Community::SteamId
    # 
    # @example Create an instance from a community URL
    #   Stew::Community::SteamId.create("http://steamcommunity.com/profiles/76561197992917668") #=> Stew::Community::SteamId
    #   
    class SteamId

      attr_reader :id

      def self.create(data, opts={})
        return self.new($1.to_i, opts) if data =~ /steamcommunity.com\/profiles\/([0-9]+)/
        return self.new($1, opts) if data =~ /steamcommunity.com\/id\/([a-zA-Z0-9]+)/
        return self.new(data, opts) if data.to_s.match /^[0-9A-Za-z]+$/
        raise SteamIdNotFoundError
      end

      def initialize(steam_id,opts={})
        @id = steam_id
        @client = opts[:client] || Stew.config[:default_community_client].new
      end

      def profile
        @profile ||= Profile.new(@client.profile(@id))
      end

      def games
        @games ||= ProfileGames.new @client.profile_games(@id)
      end

      def friends
        @friends ||= ProfileFriends.new @client.profile_friends(@id)
      end
    end

    # Error to be raised when no Steam id is found
    class SteamIdNotFoundError < StandardError; end
  end
end