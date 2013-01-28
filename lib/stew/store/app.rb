module Stew
  module Store
    class App

      attr_reader :id

      def self.create(data)
        return self.new(data) if data.class == Fixnum
        return self.new($1,{:region => $2}) if data =~ /store.steampowered.com\/app\/([0-9]+)\/?\?cc=([a-zA-Z]{2})/
        return self.new($1) if data =~ /store.steampowered.com\/app\/([0-9]+)/
        raise AppIdNotFoundError
      end

      def initialize(app_id, opts={})
        @id = app_id.to_i
        region = opts[:region] || Stew.config[:default_region]
        @client = opts[:client] || Stew.config[:default_store_client].new(region)
        @document = Nokogiri::HTML(@client.app(@id))
      end

      def score
        score_section[0].nil? ? nil : score_from_score_section
      end

      def name
        @document.css("div.apphub_AppName")[0].content
      end

      def release_date
        Date.parse @document.xpath("//b[.='Release Date:']")[0].next.content
      end

      def dlc
        !@document.css("div.game_area_dlc_bubble").empty?
      end

      def genres
        @document.css("div.glance_details").css("a").map {|node| node.content}
      end

      def developer
        @document.xpath("//a[contains(@href, 'developer')]")[0].content
      end

      def publisher
        @document.xpath("//a[contains(@href, 'publisher')]")[0].content
      end

      def price
        @document.css("div.game_purchase_price").first.content.gsub(/[\n\t\r\s]/, '')
      end

      def offers
        @document.css("div.game_area_purchase_game").map {|area| AppOffer.new(area)}
      end

      def dlc?
        dlc
      end

      def indie?
        genres.include? 'Indie'
      end

      def price
        offers.first.price
      end

      private

      def score_section
        @document.xpath("//div[@id='game_area_metascore']")
      end

      def score_from_score_section
        score_section[0].content.gsub(/[^0-9]/,'').to_i
      end

    end

    class AppIdNotFoundError < StandardError; end
  end
end