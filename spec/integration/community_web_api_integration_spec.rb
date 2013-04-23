require 'spec_helper'

describe "Community Access through the Web API", :vcr do
  describe "Creation of a steam profile with data" do
    let(:web_api_client){Stew::Community::WebApiClient.new(STEAM_API_KEY)}
    subject{Stew::Community::SteamId.create(76561197992917668, client: web_api_client)}

    describe "profile" do
      it "sets the nickname" do
        subject.profile.nickname.should eq 'MrCheese'
      end
    end

    describe "games" do
      it "creates games" do
        subject.games.collect(&:name).include?('Shank').should be_true
      end
    end

    describe "friends" do
      it "creates friends" do
        subject.friends.collect(&:id).include?(76561197972211787.to_s).should be_true
      end
    end
  end

  describe "Attempted creation of a non-existing Steam ID" do
    subject{Stew::Community::SteamId.create("www.google.com/nisse")}

    it "raises a Stew::XmlClient::ObjectNotFoundError" do
      expect{subject.profile.nickname}.to raise_error(Stew::Community::SteamIdNotFoundError)
    end
  end
end