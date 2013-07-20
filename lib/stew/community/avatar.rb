module Stew
  module Community

    # Represents the avatar for a Steam Profile
    class Avatar

      attr_reader :small, :medium, :large

      def initialize(hash)
        @small = hash['avatar']
        @medium = hash['avatarmedium']
        @large = hash['avatarfull']
      end
    end
  end
end