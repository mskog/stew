module Stew
  module Community
    class SteamId

      attr_reader :id

      def self.create(data)
        return self.new($1.to_i) if data =~ /steamcommunity.com\/profiles\/([0-9]+)/
        return self.new($1) if data =~ /steamcommunity.com\/id\/([a-zA-Z0-9]+)/
        return self.new(data) if data.to_s.match /^[0-9A-Za-z]+$/
        raise SteamIdNotFoundError
      end

      def initialize(id,opts={})
        @id = id
        @client = opts[:client] || self.class.client_with_options(id)
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

      def self.client_with_options(id)
        klass = Stew.config[:default_community_client]
        return klass.new if id.to_s.match /^[0-9]+$/
        return klass.new({:base_path => 'id'})
      end
    end

    class SteamIdNotFoundError < StandardError; end
  end
end