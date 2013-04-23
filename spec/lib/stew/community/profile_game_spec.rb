require 'spec_helper'

describe "Stew::Community::ProfileGame" do
  let(:response){JSON.parse(IO.read('spec/fixtures/profiles/games/76561197992917668.json'))}
  let(:subject){Stew::Community::ProfileGames.new(76561197992917668)}

  describe ".initialize" do
    before :each do
      data = JSON.parse(IO.read('spec/fixtures/profiles/games/76561197992917668.json'))
      @profile_game = Stew::Community::ProfileGame.new(data['response']['games'].first)
    end

    it "sets the app id" do
      @profile_game.app_id.should eq 17460
    end

    it "sets the name" do
      @profile_game.name.should eq "Mass Effect"
    end

    it "sets the logo url" do
      @profile_game.logo.should eq "http://media.steampowered.com/steamcommunity/public/images/apps/17460/7501ea5009533fa5c017ec1f4b94725d67ad4936.jpg"
    end

    it "sets the icon url" do
      @profile_game.icon.should eq "http://media.steampowered.com/steamcommunity/public/images/apps/17460/57be81f70afa48c65437df93d75ba167a29687bc.jpg"
    end

    it "sets the store url" do
      @profile_game.store_url.should eq "http://store.steampowered.com/app/17460"
    end

    it "sets the community url" do
      @profile_game.community_url.should eq "http://steamcommunity.com/app/17460"
    end

    it "sets the playertime_2weeks" do
      @profile_game.playertime_2weeks.should eq 0
    end

    it "sets the playertime_forever" do
      @profile_game.playertime_forever.should eq 3173
    end
  end
end