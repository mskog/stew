require 'spec_helper'

describe "Stew::CommunityClient" do
  let(:client){double('xml_client')}
  subject{Stew::CommunityClient.new({:client => client})}
  let(:id){76561197992917668}

  describe "#steam_id_from_vanity_name" do
    let(:response){YAML.load_file("spec/fixtures/profiles/#{id}.yml")}
    let(:name){"Somename"}

    before :each do
      Stew::XmlClient.any_instance.should_receive(:get).with("/id/#{name}").and_return(response)
    end

    context "when the vanity name exists" do
      it "returns the 64-bit id" do
        Stew::CommunityClient.steam_id_from_vanity_name(name).should eq id.to_s
      end
    end
  end

  describe "setting the base path" do
    context "when the base path is not set" do
      let(:response){YAML.load_file("spec/fixtures/profiles/#{id}.yml")}

      it "should perform requests to the 'profile'" do
        client.should_receive(:get).with("/profiles/#{id}/").and_return(response)
        subject.profile(id)
      end
    end

    context "when the base path is set to 'id'" do
      let(:response){YAML.load_file("spec/fixtures/profiles/#{id}.yml")}
      subject{Stew::CommunityClient.new({:client => client, :base_path => 'id'})}

      it "should perform profile-requests to the 'id'" do
        client.should_receive(:get).with("/id/#{id}/").and_return(response)
        subject.profile(id)
      end
    end
  end

  describe ".profile" do
    let(:response){YAML.load_file("spec/fixtures/profiles/#{id}.yml")}

    it "sends the correct message to its client" do
      client.should_receive(:get).with("/profiles/#{id}/").and_return(response)
      subject.profile(id)
    end

    it "creates a profile object" do
      client.stub(:get).with("/profiles/#{id}/").and_return(response)
      Stew::Community::Profile.should_receive(:new).with(response['profile'])
      subject.profile(id)
    end
  end

  describe ".profile_games" do
    let(:response){YAML.load_file("spec/fixtures/profiles/games/#{id}.yml")}

    it "sends the correct message to its client" do
      client.should_receive(:get).with("/profiles/#{id}/games").and_return(response)
      subject.profile_games(id)
    end

    it "creates a ProfileGames object" do
      client.stub(:get).with("/profiles/#{id}/games").and_return(response)
      Stew::Community::ProfileGames.should_receive(:new).with(response['gamesList']['games']['game'])
      subject.profile_games(id)
    end
  end

  describe ".profile_friends" do
    let(:response){YAML.load_file("spec/fixtures/profiles/friends/#{id}.yml")}

    it "sends the correct message to its client" do
      client.should_receive(:get).with("/profiles/#{id}/friends").and_return(response)
      subject.profile_friends(id)
    end

    it "returns the value of the ['friendsList']['friends']['friend'] key from the response hash" do
      client.stub(:get).with("/profiles/#{id}/friends").and_return(response)
      Stew::Community::ProfileFriends.should_receive(:new).with(response['friendsList']['friends']['friend'])
      subject.profile_friends(id)
    end
  end
end