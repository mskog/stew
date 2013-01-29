module Stew
  module Community
    class Profile

      attr_reader :id

      attr_reader :nickname

      def initialize(data)
        set_data(data)
      end

      private

      def set_data(data)
        @id = data['steamID64'].to_i
        @nickname = data['steamID']
      end
    end
  end
end