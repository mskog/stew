module Stew
  module Community
    class ProfileFriends
      include Enumerable

      def initialize(id,opts={})
        @id = id
        @client = opts[:client] || Stew.config[:default_community_client].new
      end

      def each(&block)
        friends.each(&block)
      end

      private

      def friends
        @friends ||= @client.profile_friends(@id).map{|friend| SteamId.new(friend)}
      end
    end
  end
end
