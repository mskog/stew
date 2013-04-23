module Stew
  module Community

    #Represents a Steam Game owned by a Steam Id
    class ProfileGame
      attr_reader :app_id

      attr_reader :name

      attr_reader :logo

      attr_reader :store_link

      attr_reader :playertime_2weeks

      attr_reader :playertime_forever

      def initialize(hash)
        @app_id = hash['appid'].to_i
        @name = hash['name']
        @logo = hash['logo']
        @playertime_2weeks = hash['playtime_2weeks'].to_i
        @playertime_forever = hash['playtime_forever'].to_i
        @img_logo_url = hash['img_logo_url']
        @img_icon_url = hash['img_icon_url']
      end

      def store_url
        "http://store.steampowered.com/app/#{@app_id}"
      end

      def community_url
        "http://steamcommunity.com/app/#{@app_id}"
      end

      def icon
        "http://media.steampowered.com/steamcommunity/public/images/apps/#{@app_id}/#{@img_icon_url}.jpg"
      end

      def logo
        "http://media.steampowered.com/steamcommunity/public/images/apps/#{@app_id}/#{@img_logo_url}.jpg"
      end
    end
  end
end