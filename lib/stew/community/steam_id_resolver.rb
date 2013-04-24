module Stew
  module Community

    #Resolves steam ids from numbers, urls and vanity names
    class SteamIdResolver
      attr_reader :client

      def initialize(client = Stew.config[:default_community_client].new)
        @client = client
      end

      def steam_id(data)
        data_string = data.to_s
        return data.to_i if /^[0-9]+$/ === data_string
        steam_id = @client.vanity_url_to_steam_id(data) if !data.include?('profile') && (!data.include?('/') || data =~ /steamcommunity.com/)
        return steam_id unless steam_id.nil?

        matches = /steamcommunity.com\/profiles\/([0-9]+)/.match data_string
        return matches[1].to_i if matches.nil? == false && matches.size == 2
        raise Stew::Community::SteamIdNotFoundError
      end
    end
  end
end