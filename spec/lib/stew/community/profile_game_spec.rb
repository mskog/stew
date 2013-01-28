require 'spec_helper'

describe "Stew::Community::ProfileGame" do
  let(:response){YAML.load_file('spec/fixtures/profiles/games/76561197992917668.yml')}
  let(:subject){Stew::Community::ProfileGames.new(76561197992917668)}

  describe ".initialize" do
    before :each do
      data = YAML.load_file('spec/fixtures/profiles/games/76561197992917668.yml')
      @profile_game = Stew::Community::ProfileGame.new(data['gamesList']['games']['game'].first)
    end

    it "sets the app id" do
      @profile_game.app_id.should eq 211420
    end

    it "sets the name" do
      @profile_game.name.should eq "Dark Souls: Prepare to Die Edition"
    end

    it "sets the logo url" do
      @profile_game.logo.should eq "http://media.steampowered.com/steamcommunity/public/images/apps/211420/d293c8e38f56de2c7097b2c7a975caca49029a8b.jpg"
    end

    it "sets the store link" do
      @profile_game.store_link.should eq "http://steamcommunity.com/app/211420"
    end

    it "sets the minutes_last_2_weeks" do
      @profile_game.minutes_last_2_weeks.should eq 1013
    end

    it "sets the minutes_total" do
      @profile_game.minutes_total.should eq 1013
    end
  end

  describe ".app" do
    let(:id){211420}
    let(:subject){
      data = YAML.load_file('spec/fixtures/profiles/games/76561197992917668.yml')
      Stew::Community::ProfileGame.new(data['gamesList']['games']['game'].first)
    }

    it "returns an instance of Stew::Store::App" do
      app = double('profile', :class => Stew::Store::App)
      Stew::Store::App.should_receive(:new).with(id).and_return(app)
      subject.app.class.should eq Stew::Store::App
    end

    it "has the same id as the ProfileGame" do
      app = double('profile', :id => 211420)
      Stew::Store::App.should_receive(:new).with(id).and_return(app)
      subject.app.id.should eq 211420
    end
  end
end