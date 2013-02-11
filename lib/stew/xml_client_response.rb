module Stew

  # A response from the Xml Client
  # Handles edge cases such as profiles with no games or friends
  class XmlClientResponse
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def profile
      @response['profile']
    end

    def games
      has_games? ? @response['gamesList']['games']['game'] : []
    end

    def friends
      has_friends? ? @response['friendsList']['friends']['friend'] : []
    end

    private

    def has_games?
      !@response['gamesList']['games'].empty?
    end

    def has_friends?
      !@response['friendsList']['friends'].empty?
    end
  end
end