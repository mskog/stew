module Stew
  module Community
    class Profile

      attr_reader :id

      attr_reader :id64

      attr_reader :nickname

      def initialize(hash)
        set_data(hash)
      end

      private

      def set_data(data)
        @id = data['steamID64'].to_i
        @id64 = data['steamID64']
        @nickname = data['steamID']
      end
    end
  end
end