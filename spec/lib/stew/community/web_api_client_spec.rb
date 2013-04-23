require 'spec_helper'

describe "Stew::Community::WebApiClient" do
  let(:client){double('xml_client')}
  subject{Stew::Community::WebApiClient.new(STEAM_API_KEY,client)}

  describe ".profile" do
    it "sends the 'get' message to its client with the correct parameters" do
      steam_id = 12345
      expected_argument = "/ISteamUser/GetPlayerSummaries/v0002/?key=#{STEAM_API_KEY}&steamids=#{steam_id}"
      client.should_receive(:get).with(expected_argument)
      subject.profile(steam_id)
    end
  end
end