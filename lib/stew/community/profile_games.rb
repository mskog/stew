module Stew
  module Community
    class ProfileGames
      include Enumerable

      def initialize(profile_id, opts = {})
        @id = profile_id
        @client = opts[:client] || Stew.config[:default_community_client].new
      end

      def each(&block)
        games.each(&block)
      end

      private

      def games
        @games ||= Array.new(@client.profile_games(@id)).map{|game| ProfileGame.new(game)}
      end
    end
  end
end
