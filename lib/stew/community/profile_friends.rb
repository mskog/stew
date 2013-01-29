module Stew
  module Community
    class ProfileFriends
      include Enumerable

      def initialize(data)
        @friends = data.map {|friend| SteamId.new(friend)}
      end

      def each(&block)
        @friends.each(&block)
      end
    end
  end
end
