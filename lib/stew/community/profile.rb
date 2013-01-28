module Stew
  module Community
    class Profile
      include FetchableAttributes

      attr_reader_fetchable :id

      attr_reader_fetchable :id64

      attr_reader_fetchable :nickname

      def initialize(id, opts = {})
        @id = id
        @client = opts[:client] || Stew.config[:default_community_client].new
      end

      private

      def fetch
        set_data(@client.profile(id))
      end

      def set_data(data)
        @id64 = data['steamID64']
        @nickname = data['steamID']
      end
    end
  end
end