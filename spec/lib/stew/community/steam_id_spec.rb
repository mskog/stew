require 'spec_helper'

describe "Stew::Community::SteamId" do
  let(:id){76561197992917668}
  let(:steam_id){12345}
  let(:client){double('client')}
  let(:resolver){double}

  subject{Stew::Community::SteamId.new(id, client: client)}

  before :each do
    Stew::Community::SteamIdResolver.stub(:new).and_return(resolver)
    resolver.stub(:steam_id) {id}
  end

  describe ".initialize" do
    it "uses an instance of SteamIdResolver to get the id" do
      resolver.should_receive(:steam_id).with(id).and_return(id)
      subject.id.should eq id
    end
  end

  describe ".profile" do
    let(:data){double}

    it "returns a steam profile from the data received from the community client" do
      client.should_receive(:profile).with(id).once.and_return(data)
      Stew::Community::Profile.should_receive(:new).with(data).once.and_return(double)
      subject.profile
      subject.profile
    end
  end

  describe ".games" do
    let(:data){double}

    it "returns the games from the data received from the community client" do
      client.should_receive(:profile_games).with(id).once.and_return(data)
      Stew::Community::ProfileGames.should_receive(:new).with(data).once.and_return(double)
      subject.games
      subject.games
    end
  end

  describe ".friends" do
    let(:data){double}

    it "returns the friends from the data received from the community client" do
      client.should_receive(:profile_friends).with(id).once.and_return(data)
      Stew::Community::ProfileFriends.should_receive(:new).with(data).once.and_return(double)
      subject.friends
      subject.friends
    end
  end
end