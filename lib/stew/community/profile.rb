module Stew
  module Community

    # Represents the base data for a Steam Profile
    class Profile

      attr_reader :id

      attr_reader :nickname

      def initialize(hash)
        set_data(hash)
      end

      private

      def set_data(data)
        @id = data['steamid'].to_i
        @nickname = data['personaname']
      end
    end
  end
end