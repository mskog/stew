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
        return @client.vanity_url_to_steam_id(data) unless data.include?('profile')

        matches = /steamcommunity.com\/profiles\/([0-9]+)/.match data_string
        return matches[1].to_i if matches.size == 2
      end
    end
  end
end