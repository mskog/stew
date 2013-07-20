module Stew
  module Community

    # Represents the base data for a Steam Profile
    class Profile

      attr_reader :id, :nickname, :last_logoff, :avatar

      def initialize(hash)
        set_data(hash)
      end

      private

      def set_data(data)
        @id = data['steamid'].to_i
        @nickname = data['personaname']
        @last_logoff = Time.at data['lastlogoff']
        @avatar = Avatar.new(data)
      end
    end
  end
end