require 'spec_helper'

describe "Stew::XmlClientResponse" do
  let(:id){76561197992917668}
  subject{Stew::XmlClientResponse.new(response)}

  describe ".profile" do
    let(:response){YAML.load_file("spec/fixtures/profiles/#{id}.yml")}

    it "returns the profile from the hash" do
      subject.profile.should eq response['profile']
    end
  end

  describe ".games" do
    let(:response){YAML.load_file("spec/fixtures/profiles/games/#{id}.yml")}

    context "when the profile has games" do
      it "returns the games from the hash" do
        subject.games.should eq response['gamesList']['games']['game']
      end
    end

    context "when the user has no games" do
      let(:id){76561197994486912}

      it "returns an empty array" do
        subject.games.should eq []
      end
    end
  end

  describe ".friends" do
    let(:response){YAML.load_file("spec/fixtures/profiles/friends/#{id}.yml")}

    context "when the profile has friends" do
      it "returns the friends from the hash" do
        subject.friends.should eq response['friendsList']['friends']['friend']
      end
    end

    context "when the user has no friends" do
      let(:id){76561197994486912}

      it "returns an empty array" do
        subject.friends.should eq []
      end
    end
  end

end