require 'spec_helper'

describe "Stew::Community::WebApiClient" do
  let(:client){double('xml_client')}
  let(:response){YAML.load_file("spec/fixtures/profiles/#{steam_id}.json")}
  let(:steam_id){76561197992917668}
  subject{Stew::Community::WebApiClient.new(STEAM_API_KEY,client)}

  describe ".profile" do
    it "sends the 'get' message to its client with the correct parameters" do
      expected_argument = "/ISteamUser/GetPlayerSummaries/v0002/?key=#{STEAM_API_KEY}&steamids=#{steam_id}"
      client.should_receive(:get).with(expected_argument).and_return(response)
      subject.profile(steam_id)
    end
  end

  describe ".profile_games" do
    it "sends the 'get' message to its client with the correct parameters" do
      expected_argument = "/IPlayerService/GetOwnedGames/v0001/?key=#{STEAM_API_KEY}&steamid=#{steam_id}&include_appinfo=1"
      client.should_receive(:get).with(expected_argument).and_return(response)
      subject.profile_games(steam_id)
    end
  end
end