module Stew
  module Community

    # Represents the friends of a Steam profile
    # Enumerates a list of Steam Id instances
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
