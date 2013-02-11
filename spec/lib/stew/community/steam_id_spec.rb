require 'spec_helper'

describe "Stew::Community::SteamId" do
  let(:id){76561197992917668}
  let(:community_client){double('community_client')}

  subject{Stew::Community::SteamId.new(id,{:client => community_client})}

  describe "#create" do
    context "when the parameter is an integer" do
      it "creates a steam_id with the given integer as id" do
        Stew::Community::SteamId.create(id).id.should eq id
      end
    end

    context "when the parameter is a steamcommunity url" do
      let(:url){"http://steamcommunity.com/profiles/#{id}"}

      it "creates a steam_id with the id in the given string as id" do
        Stew::Community::SteamId.create(url).id.should eq id
      end
    end

    context "when the parameter is a vanity url" do
      let(:name){"somename"}
      let(:url){"http://steamcommunity.com/id/#{name}"}

      it "creates a steamid with the vanity name as first parameter" do
        Stew::Community::SteamId.should_receive(:new).with(name)
        Stew::Community::SteamId.create(url)
      end
    end

    context "when the parameter is a vanity name" do
      let(:name){"somename"}

      it "creates a steamid with the vanity name as first parameter" do
        Stew::Community::SteamId.should_receive(:new).with(name)
        Stew::Community::SteamId.create(name)

      end
    end

    context "when the parameter is a url that cannot be matched" do
      it "raises a SteamIdNotFound error" do
        expect{Stew::Community::SteamId.create('sdfsdf/dsfsdf/com')}.to raise_error(Stew::Community::SteamIdNotFoundError)
      end
    end
  end

  describe ".initialize" do

    context "when the id is a number" do
      it "sets the id" do
        subject.id.should eq id
      end

      it "should create a community client with no options" do
        Stew::Community::CommunityClient.should_receive(:new).with()
        Stew::Community::SteamId.new(id)
      end
    end

    context "when the id is a vanity name" do
      let(:id){"foobar20"}

      it "sets the id" do
        subject.id.should eq id
      end

      it "should create a community client with the base_path option set to 'id'" do
        Stew::Community::CommunityClient.should_receive(:new).with({:base_path => 'id'})
        Stew::Community::SteamId.new(id)
      end
    end
  end

  describe ".profile" do
    it "calls profile on the community_client" do
      community_client.should_receive(:profile).with(id)
      subject.profile
    end

    it "only calls profile on the community_client once" do
      community_client.should_receive(:profile).with(id).once.and_return(double('profile'))
      subject.profile
      subject.profile
    end
  end

  describe ".games" do
    it "calls profile_games on the community_client" do
      community_client.should_receive(:profile_games).with(id)
      subject.games
    end

    it "only calls games on the community_client once" do
      community_client.should_receive(:profile_games).with(id).once.and_return(double('profile_games'))
      subject.games
      subject.games
    end
  end

  describe ".friends" do
    it "calls profile_friends on the community_client" do
      community_client.should_receive(:profile_friends).with(id)
      subject.friends
    end

    it "only calls friends on the community_client once" do
      community_client.should_receive(:profile_friends).with(id).once.and_return(double('profile_friends'))
      subject.friends
      subject.friends
    end
  end
end