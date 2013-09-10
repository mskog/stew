require 'spec_helper'

describe "Stew::Community::WebApiClient" do
  let(:client){double('xml_client')}
  subject{Stew::Community::WebApiClientNoKey.new(client)}

  describe ".number_of_current_players" do
    let(:response){JSON.parse(IO.read("spec/fixtures/user_stats/number_of_current_players_#{app_id}.json"))}
    let(:app_id){570}

    it "returns the number" do
      expected_argument = "/ISteamUserStats/GetNumberOfCurrentPlayers/v1?appid=#{app_id}"
      client.should_receive(:get).with(expected_argument).and_return(response)
      subject.number_of_current_players(app_id).should eq 373834
    end
  end
end
