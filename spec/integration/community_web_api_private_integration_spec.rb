require 'spec_helper'

describe "Community Access through the Web API for private profiles", :vcr do
  describe "Creation of a private steam profile" do
    subject{Stew::Community::SteamId.new('http://steamcommunity.com/id/gamespazm')}

    describe "profile" do
      it "raises a PrivateProfileError" do
        expect{subject.profile}.to raise_error(Stew::Community::PrivateProfileError)
      end
    end

    describe "games" do
      it "raises a PrivateProfileError" do
        expect{subject.games}.to raise_error(Stew::Community::PrivateProfileError)
      end
    end

    describe "friends" do
      it "raises a PrivateProfileError" do
        expect{subject.friends}.to raise_error(Stew::Community::PrivateProfileError)
      end
    end
  end
end