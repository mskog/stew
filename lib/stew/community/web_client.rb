module Stew
  module Community
    class WebClient
      def initialize(uri)
        @connection = self.class.connection(uri)
      end

      def get(uri)
        request(uri)
      end

      private

      def request(path)
        @connection.get path
      end

      def self.connection(uri)
        Faraday.new uri do |conn|
          conn.request :json
          conn.request :retry
          conn.response :json,  :content_type => /\bjson$/
          conn.use FaradayMiddleware::FollowRedirects
          conn.adapter Faraday.default_adapter
        end
      end
    end
  end
end