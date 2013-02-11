module Stew
  module Community
    # A games response from the Xml Client
    class XmlClientResponseGames
      def initialize(response)
        @response = response
      end

      def games
        has_games? ? @response['gamesList']['games']['game'] : []
      end

      private

      def has_games?
        !@response['gamesList']['games'].nil?
      end
    end
  end
end