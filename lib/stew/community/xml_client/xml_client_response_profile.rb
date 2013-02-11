module Stew
  module Community
    # A profile response from the Xml Client
    class XmlClientResponseProfile
      def initialize(response)
        @response = response
      end

      def profile
        @response['profile']
      end
    end
  end
end