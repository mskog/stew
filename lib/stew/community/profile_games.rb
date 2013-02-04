module Stew
  module Community

    #Represents the ProfileGame instances owned by a steam id
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
