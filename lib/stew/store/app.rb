module Stew
  module Store
    class App
      def initialize(response)
        @document = Nokogiri::HTML(response)
      end

      def score
        score_section[0].nil? ? nil : score_from_score_section
      end

      def name
        @document.at_css("div.apphub_AppName").content
      end

      def release_date
        Date.parse @document.at_xpath("//b[.='Release Date:']").next.content
      end

      def dlc
        !@document.css("div.game_area_dlc_bubble").empty?
      end

      def genres
        @document.css("div.glance_details").css("a").map {|node| node.content}
      end

      def developer
        @document.at_xpath("//a[contains(@href, 'developer')]").content
      end

      def publisher
        @document.at_xpath("//a[contains(@href, 'publisher')]").content
      end

      def price
        @document.at_css("div.game_purchase_price").content.gsub(/[\n\t\r\s]/, '')
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
  end
end