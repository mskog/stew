module Stew
  module Store
    class App
      def initialize(response)
        @document = Nokogiri::HTML(response)
      end

      def score
        score_section[0] && score_from_score_section
      end

      def name
        App.content_or_nil @document.at_css("div.apphub_AppName")
      end

      def release_date
        node = @document.at_xpath("//b[.='Release Date:']")
        node && Date.parse(node.next.content)
      end

      def genres
        @document.css("div.glance_details").css("a").map {|node| node.content}
      end

      def developer
        App.content_or_nil @document.at_xpath("//a[contains(@href, 'developer')]")
      end

      def publisher
        App.content_or_nil @document.at_xpath("//a[contains(@href, 'publisher')]")
      end

      def price
        @document.at_css("div.game_purchase_price").content.gsub(/[\n\t\r\s]/, '')
      end

      def offers
        @document.css("div.game_area_purchase_game").map {|area| AppOffer.create(area)}
      end

      def dlc?
        @document.at_css("div.game_area_dlc_bubble")
      end

      def indie?
        genres.include? 'Indie'
      end

      def price
        return nil if offers.empty?
        first_offer_price
      end

      def free?
        offers.empty?
      end

      private

      def first_offer_price
        offers.first.price
      end

      def self.content_or_nil(item)
        item && item.content
      end

      def score_section
        @document.xpath("//div[@id='game_area_metascore']")
      end

      def score_from_score_section
        score_section[0].content.gsub(/[^0-9]/,'').to_i
      end
    end
  end
end