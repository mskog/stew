module Stew
  module Community
    # A friends response from the Xml Client
    class XmlClientResponseFriends
      def initialize(response)
        @response = response
      end

      def friends
        has_friends? ? @response['friendsList']['friends']['friend'] : []
      end

      private

      def has_friends?
        !@response['friendsList']['friends'].nil?
      end
    end
  end
end