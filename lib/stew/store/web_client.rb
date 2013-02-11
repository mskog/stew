module Stew
  module Store
    # Client wrapper for performing requests to the Steam Store
    class WebClient
      def initialize(uri)
        @connection = WebClient.connection(uri)
      end

      def get(path, options={})
        request(path, options).body
      end

      private

      def request(path,options={})
        @connection.get(path) do |request|
          request.params = options
        end
      end

      def self.connection(uri)
        Faraday.new uri do |conn|
          conn.headers[:cookie] = "birthtime=365842801"
          conn.request :retry
          conn.use FaradayMiddleware::FollowRedirects
          conn.adapter Faraday.default_adapter
        end
      end
    end
  end
end