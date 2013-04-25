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

        matches = (/steamcommunity.com\/(id|profiles|)\/([a-z0-9]+)/i).match(data_string)
        steam_id = steam_id_from_matches(data,matches)
        return steam_id unless steam_id.nil?
        raise Stew::Community::SteamIdNotFoundError
      end

    private
      def steam_id_from_matches(data, matches)
        if matches.nil?
          return @client.vanity_url_to_steam_id(data) unless data.include?('/')
        elsif matches[1] != 'profiles'
          return @client.vanity_url_to_steam_id(data)
        else
          return matches[2].to_i
        end
      end
    end
  end
end