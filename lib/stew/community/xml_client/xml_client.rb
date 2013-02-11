module Stew
  module Community
    # Client for accessing the steam community XML api
    class XmlClient
      def initialize(uri)
        @connection = XmlClient.connection(uri)
      end

      # The Steam community is notorious for responding with error 503
      # Retries up to 10 times for the same request to compensate for this
      def get(path)
        10.times do
          response = request(path)
          return XmlClient.parse_response(response.body) unless response.status == 503
          sleep 0.5
        end
        raise ServiceUnavailableError
      end

      private

      def request(path)
        @connection.get path do |req|
          req.params['xml'] = 1
        end
      end

      def self.connection(uri)
        Faraday.new uri do |conn|
          conn.response :xml,  :content_type => /\bxml$/
          conn.request :retry
          conn.use FaradayMiddleware::FollowRedirects
          conn.adapter Faraday.default_adapter
        end
      end

      def self.parse_response(response)
        raise(ObjectNotFoundError) if response.is_a?(String)
        raise(ObjectNotFoundError, response['response']['error']) if response.has_key?('response')
        response
      end

      # Raised when the Steam community API fails to respond after 10 tries
      class ServiceUnavailableError < StandardError; end

      # Raised when the reply is malformatted or if nothing is found
      class ObjectNotFoundError < StandardError; end
    end
  end
end