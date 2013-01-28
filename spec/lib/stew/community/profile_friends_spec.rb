require 'spec_helper'

describe "Stew::Community::ProfileFriends" do
  let(:id){76561197992917668}
  let(:response){YAML.load_file('spec/fixtures/profiles/friends/76561197992917668.yml')['friendsList']['friends']['friend']}
  let(:community_client) do
    client = double("community_client")
    client.stub(:profile_friends).with(id).and_return(response)
    client
  end

  let(:subject){Stew::Community::ProfileFriends.new(id, {:client => community_client})}

  describe ".entries" do
    it "sets the friends" do
      response.each do |friend|
        Stew::Community::SteamId.should_receive(:new).with(friend)
      end
      subject.entries.count.should eq 30
    end
  end

  describe ".each" do
    let(:subject){Stew::Community::ProfileFriends.any_instance.stub(:fetch);Stew::Community::ProfileFriends.new(12345)}

    it "invokes the given block for each object returned by the friends method" do
      friend1 = double(:name => 'Half-Life 2')
      friend2 = double(:name => 'Shank')
      friends = [friend1,friend2]

      friend1.should_receive(:name)
      friend2.should_receive(:name)
      subject.instance_eval do
        @friends = friends
      end

      subject.each do |friend|
        friend.name
      end
    end
  end

end