require 'spec_helper'

describe "Stew::Community::WebApiClient" do
  let(:client){double('xml_client')}
  let(:response){JSON.parse(IO.read("spec/fixtures/profiles/#{steam_id}.json"))}
  let(:steam_id){76561197992917668}
  subject{Stew::Community::WebApiClient.new(client)}


  describe ".vanity_url_to_steam_id" do
    let(:response){JSON.parse(IO.read("spec/fixtures/profiles/vanity/#{vanity_name}.json"))}

    context "when given a name" do
      let(:vanity_name){'Phucked'}

      it "sends the 'get' message to its client with the correct parameters" do
        expected_argument = "/ISteamUser/ResolveVanityURL/v0001/?key=#{STEAM_API_KEY}&vanityurl=#{vanity_name}"
        client.should_receive(:get).with(expected_argument).and_return(response)
        subject.vanity_url_to_steam_id(vanity_name).should eq 76561198013177911
      end
    end

    context "when given a url" do
      let(:vanity_name){'Phucked'}
      let(:vanity_url){"http://steamcommunity.com/id/#{vanity_name}"}

      it "sends the 'get' message to its client with the correct parameters" do
        expected_argument = "/ISteamUser/ResolveVanityURL/v0001/?key=#{STEAM_API_KEY}&vanityurl=#{vanity_name}"
        client.should_receive(:get).with(expected_argument).and_return(response)
        subject.vanity_url_to_steam_id(vanity_url).should eq 76561198013177911
      end
    end
  end

  describe ".profile" do
    let(:response){JSON.parse(IO.read("spec/fixtures/profiles/#{steam_id}.json"))}

    context "when given an existing steam id" do
      let(:response){JSON.parse(IO.read("spec/fixtures/profiles/#{steam_id}.json"))}
      it "sends the 'get' message to its client with the correct parameters" do
        expected_argument = "/ISteamUser/GetPlayerSummaries/v0002/?key=#{STEAM_API_KEY}&steamids=#{steam_id}"
        client.should_receive(:get).with(expected_argument).and_return(response)
        subject.profile(steam_id)['steamid'].to_i.should eq steam_id
      end
    end

    context "when given a non-existant steam id" do
      let(:steam_id){4}

      it "raises a ProfileNotFoundError" do
        expected_argument = "/ISteamUser/GetPlayerSummaries/v0002/?key=#{STEAM_API_KEY}&steamids=#{steam_id}"
        client.should_receive(:get).with(expected_argument).and_return(response)
        expect{subject.profile(steam_id)}.to raise_error(Stew::Community::ProfileNotFoundError)
      end
    end

    context "when given a private steam id" do
      let(:response){JSON.parse(IO.read("spec/fixtures/profiles/private.json"))}

      it "raises a PrivateProfileError" do
        expected_argument = "/ISteamUser/GetPlayerSummaries/v0002/?key=#{STEAM_API_KEY}&steamids=#{steam_id}"
        client.should_receive(:get).with(expected_argument).and_return(response)
        expect{subject.profile(steam_id)}.to raise_error(Stew::Community::PrivateProfileError)
      end
    end
  end

  describe ".profile_games" do
    let(:response){JSON.parse(IO.read("spec/fixtures/profiles/games/#{steam_id}.json"))}

    context "when given an existing steam id" do
      let(:response){JSON.parse(IO.read("spec/fixtures/profiles/games/#{steam_id}.json"))}
      it "sends the 'get' message to its client with the correct parameters" do
        expected_argument = "/IPlayerService/GetOwnedGames/v0001/?key=#{STEAM_API_KEY}&steamid=#{steam_id}&include_appinfo=1"
        client.should_receive(:get).with(expected_argument).and_return(response)
        subject.profile_games(steam_id).count.should eq 106
      end
    end

    context "when given a non-existant steam id" do
      let(:steam_id){4}

      it "raises a ProfileNotFoundError" do
        expected_argument = "/IPlayerService/GetOwnedGames/v0001/?key=#{STEAM_API_KEY}&steamid=#{steam_id}&include_appinfo=1"
        client.should_receive(:get).with(expected_argument) {raise Stew::Community::WebClientError}
        expect{subject.profile_games(steam_id)}.to raise_error(Stew::Community::ProfileNotFoundError)
      end
    end

    context "when given a private steam id" do
      let(:response){JSON.parse(IO.read("spec/fixtures/profiles/games/private.json"))}

      it "raises a PrivateProfileError" do
        expected_argument = "/IPlayerService/GetOwnedGames/v0001/?key=#{STEAM_API_KEY}&steamid=#{steam_id}&include_appinfo=1"
        client.should_receive(:get).with(expected_argument).and_return(response)
        expect{subject.profile_games(steam_id)}.to raise_error(Stew::Community::PrivateProfileError)
      end
    end

  end

  describe ".profile_friends" do
    context "when given an existing steam id" do
      let(:response){JSON.parse(IO.read("spec/fixtures/profiles/friends/#{steam_id}.json"))}
      it "sends the 'get' message to its client with the correct parameters" do
        expected_argument = "/ISteamUser/GetFriendList/v0001/?key=#{STEAM_API_KEY}&steamid=#{steam_id}&relationship=friend"
        client.should_receive(:get).with(expected_argument).and_return(response)
        subject.profile_friends(steam_id).count.should eq 32
      end
    end

    context "when given a non-existant steam id" do
      it "raises a ProfileNotFoundError" do
        expected_argument = "/ISteamUser/GetFriendList/v0001/?key=#{STEAM_API_KEY}&steamid=#{steam_id}&relationship=friend"
        client.should_receive(:get).with(expected_argument) {raise Stew::Community::WebClientError}
        expect{subject.profile_friends(steam_id)}.to raise_error(Stew::Community::ProfileNotFoundError)
      end
    end

    context "when given a private steam id" do
      let(:response){JSON.parse(IO.read("spec/fixtures/profiles/friends/private.json"))}

      it "raises a PrivateProfileError" do
        expected_argument = "/ISteamUser/GetFriendList/v0001/?key=#{STEAM_API_KEY}&steamid=#{steam_id}&relationship=friend"
        client.should_receive(:get).with(expected_argument).and_return(response)
        expect{subject.profile_friends(steam_id)}.to raise_error(Stew::Community::PrivateProfileError)
      end
    end

  end
end