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

      def initialize(data,opts={})
        @client = opts[:client] || Stew.config[:default_community_client].new
        @id = SteamIdResolver.new(@client).steam_id(data)
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

    # Error to be raised when the Steam Id is private
    class PrivateProfileError < StandardError; end
  end
end