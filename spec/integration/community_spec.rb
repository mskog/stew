require 'spec_helper'

describe "Community", :vcr do
  describe "Creation of a steam id with data" do
    subject{Stew::Community::SteamId.new(76561197992917668)}

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
      it "adds friends" do
        subject.friends.collect(&:id).include?(76561198005505133.to_s).should be_true
      end
    end
  end

  describe "Attempted creation of a non-existing Steam ID" do
    subject{Stew::Community::SteamId.create("www.google.com/nisse")}

    it "raises a Stew::XmlClient::ObjectNotFoundError" do
      expect{subject.profile.nickname}.to raise_error(Stew::Community::SteamIdNotFoundError)
    end
  end

  describe "Creation of a steam id that has a set vanity url" do
    it "properly follows redirects and parses the data" do
      steam_id = Stew::Community::SteamId.new(76561197960889223)
      steam_id.profile.id.should eq 76561197960889223
    end
  end

  describe "Creation of a steam id from a URL" do
    let(:id){76561197992917668}
    let(:url){"http://steamcommunity.com/profiles/#{id}"}

    it "creates the steam id" do
      steam_id = Stew::Community::SteamId.create(url)
      steam_id.id.should eq id
    end
  end
end