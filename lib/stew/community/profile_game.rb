module Stew
  module Community
    class ProfileGame
      attr_reader :app_id

      attr_reader :app

      attr_reader :name

      attr_reader :logo

      attr_reader :store_link

      attr_reader :hours_last_2_weeks

      attr_reader :hours_on_record

      def initialize(hash)
        @app_id = hash['appID'].to_i
        @name = hash['name']
        @logo = hash['logo']
        @store_link = hash['storeLink']
        @hours_last_2_weeks = hash['hoursLast2Weeks'].to_f
        @hours_on_record = hash['hoursOnRecord'].to_f
      end

      def app
        @app ||= Stew::Store::App.new(@app_id)
      end
    end
  end
end