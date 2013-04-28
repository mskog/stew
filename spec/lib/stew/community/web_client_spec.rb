require 'spec_helper'

describe Stew::Community::WebClient do
  let(:base_uri){"http://api.steampowered.com"}

  subject{Stew::Community::WebClient.new(base_uri)}

  describe ".get" do
    context "when the response is OK" do
      it "performs a request to the expected URL and returns the results" do
        steam_id = 12345
        uri = "/ISteamUser/GetPlayerSummaries/v0002/?key=#{STEAM_API_KEY}&steamids=#{steam_id}"
        stub = stub_request(:get, "http://api.steampowered.com#{uri}")
        subject.get(uri)
        stub.should have_been_requested
      end
    end

    context "when the response has status 500" do
      it "raises a WebClientError" do
        steam_id = 4
        uri = "/ISteamUser/GetPlayerSummaries/v0002/?key=#{STEAM_API_KEY}&steamids=#{steam_id}"
        stub_request(:get, "http://api.steampowered.com#{uri}").to_return(:status => [500, "Internal Server Error"])
        expect{subject.get(uri)}.to raise_error(Stew::Community::WebClientError)
      end
    end
  end
end