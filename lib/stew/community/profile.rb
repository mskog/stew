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
        @id = data['steamID64'].to_i
        @nickname = data['steamID']
      end
    end
  end
end