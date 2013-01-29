module Stew
  module Community
    class ProfileGames
      include Enumerable

      def initialize(data)
        @games = Array.new(data.map{|game| ProfileGame.new(game)})
      end

      def each(&block)
        @games.each(&block)
      end
    end
  end
end
