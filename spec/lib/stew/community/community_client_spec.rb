require 'spec_helper'

describe "Stew::CommunityClient" do
  let(:client){double('xml_client')}
  subject{Stew::Community::CommunityClient.new({:client => client})}
  let(:id){76561197992917668}

  describe "#steam_id_from_vanity_name" do
    let(:vanity_name){"foobar"}

    it "calls steam_id_from_vanity_name on a new instance" do
      Stew::Community::CommunityClient.any_instance.should_receive(:steam_id_from_vanity_name).with(vanity_name)
      Stew::Community::CommunityClient.steam_id_from_vanity_name(vanity_name)
    end
  end


  describe ".steam_id_from_vanity_name" do
    let(:response){YAML.load_file("spec/fixtures/profiles/#{id}.yml")}
    let(:name){"Somename"}

    before :each do
      client.should_receive(:get).with("/id/#{name}").and_return(response)
    end

    context "when the vanity name exists" do
      it "returns the 64-bit id" do
        subject.steam_id_from_vanity_name(name).should eq id
      end
    end
  end

  describe "setting the base path" do
    context "when the base path is not set" do
      let(:results){YAML.load_file("spec/fixtures/profiles/#{id}.yml")}

      it "should perform requests to the 'profile'" do
        client.should_receive(:get).with("/profiles/#{id}/").and_return(results)
        subject.profile(id)
      end
    end

    context "when the base path is set to 'id'" do
      let(:results){YAML.load_file("spec/fixtures/profiles/#{id}.yml")}
      subject{Stew::Community::CommunityClient.new({:client => client, :base_path => 'id'})}

      it "should perform profile-requests to the 'id'" do
        client.should_receive(:get).with("/id/#{id}/").and_return(results)
        subject.profile(id)
      end
    end
  end

  describe ".profile" do
    let(:results){YAML.load_file("spec/fixtures/profiles/#{id}.yml")}

    it "sends the correct message to its client" do
      client.should_receive(:get).with("/profiles/#{id}/").and_return(results)
      subject.profile(id).should eq results['profile']
    end
  end

  describe ".profile_games" do
    let(:results){YAML.load_file("spec/fixtures/profiles/games/#{id}.yml")}

    it "sends the correct message to its client" do
      client.should_receive(:get).with("/profiles/#{id}/games").and_return(results)
      subject.profile_games(id).should eq results['gamesList']['games']['game']
    end
  end

  describe ".profile_friends" do
    let(:results){YAML.load_file("spec/fixtures/profiles/friends/#{id}.yml")}

    it "sends the correct message to its client" do
      client.should_receive(:get).with("/profiles/#{id}/friends").and_return(results)
      subject.profile_friends(id).should eq results['friendsList']['friends']['friend']
    end
  end
end