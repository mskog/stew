module Stew
  module Store
    
    # An application in the Steam Store
    # Initialized from the contents of a web request to the Steam store app page
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

      def header_image
        App.src_or_nil @document.at_css('img.game_header_image')
      end

      def offers
        @offers ||= AppOffers.new @document.css("div.game_area_purchase_game")
      end

      def dlc?
        !@document.css("div.game_area_dlc_bubble").empty?
      end

      def dlc_app_id
        return nil unless dlc?
        #Close your eyes...
        @document.at_css("div.game_area_dlc_bubble").at_css('a').attributes['href'].value[/\d+/].to_i
      end

      def indie?
        genres.include? 'Indie'
      end

      def price
        return nil if free?
        first_offer_price
      end

      def free?
        offers.count == 0
      end

      private

      def first_offer_price
        offers.first.price
      end

      def self.content_or_nil(item)
        item && item.content
      end

      def self.src_or_nil(item)
        item && item[:src].split("?").first
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