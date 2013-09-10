module Stew
  module Community

    # User statistics such as number of current users for an app
    class UserStats
      def initialize(opts={})
        @client = opts[:client] || WebApiClientNoKey.new
      end

      def number_of_current_players(app_id)
        @client.number_of_current_players(app_id)
      end
    end
  end
end