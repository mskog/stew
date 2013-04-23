require 'spec_helper'

describe Stew::Community::WebClient do
  let(:base_uri){"http://api.steampowered.com"}

  subject{Stew::Community::WebClient.new(base_uri)}

  describe ".get" do
    it "performs a request to the expected URL and returns the results" do
      steam_id = 12345
      uri = "/ISteamUser/GetPlayerSummaries/v0002/?key=#{STEAM_API_KEY}&steamids=#{steam_id}"
      stub = stub_request(:get, "http://api.steampowered.com#{uri}")
      subject.get(uri)
      stub.should have_been_requested
    end
  end
end