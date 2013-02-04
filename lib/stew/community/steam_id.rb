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

      def self.create(data)
        return self.new($1.to_i) if data =~ /steamcommunity.com\/profiles\/([0-9]+)/
        return self.new($1) if data =~ /steamcommunity.com\/id\/([a-zA-Z0-9]+)/
        return self.new(data) if data.to_s.match /^[0-9A-Za-z]+$/
        raise SteamIdNotFoundError
      end

      def initialize(steam_id,opts={})
        @id = steam_id
        @client = opts[:client] || self.class.client_with_options(steam_id)
      end

      def profile
        @profile ||= @client.profile @id
      end

      def games
        @games ||= @client.profile_games @id
      end

      def friends
        @friends ||= @client.profile_friends @id
      end

      private

      def self.client_with_options(steam_id)
        klass = Stew.config[:default_community_client]
        return klass.new if steam_id.to_s.match /^[0-9]+$/
        return klass.new({:base_path => 'id'})
      end
    end

    # Error to be raised when no Steam id is found
    class SteamIdNotFoundError < StandardError; end
  end
end