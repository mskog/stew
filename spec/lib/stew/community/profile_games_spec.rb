require 'spec_helper'

describe "Stew::Community::ProfileGames" do
  let(:id){76561197992917668}
  let(:response){YAML.load_file('spec/fixtures/profiles/games/76561197992917668.yml')['gamesList']['games']['game']}

  let(:community_client) do
    client = double("community_client")
    client.stub(:profile_games).with(id).and_return(response)
    client
  end

  let(:subject){Stew::Community::ProfileGames.new(id, {:client => community_client})}

  describe ".entries" do
    it "sets the games" do
      response.each do |game|
        Stew::Community::ProfileGame.should_receive(:new).with(game)
      end
      subject.entries.count.should eq 102
    end
  end

  describe ".each" do
    it "invokes the given block for each object returned by the games method" do
      game1 = double(:name => 'Half-Life 2')
      game2 = double(:name => 'Shank')
      games = [game1,game2]

      game1.should_receive(:name)
      game2.should_receive(:name)
      subject.instance_eval do
        @games = games
      end

      subject.each do |game|
        game.name
      end
    end
  end

end