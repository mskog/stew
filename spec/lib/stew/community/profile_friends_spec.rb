require 'spec_helper'

describe "Stew::Community::ProfileFriends" do
  let(:id){76561197992917668}
  let(:response){JSON.parse(IO.read('spec/fixtures/profiles/friends/76561197992917668.json'))['friendslist']['friends']}

  let(:subject){Stew::Community::ProfileFriends.new(response)}

  describe ".entries" do
    it "sets the friends" do
      response.each do |friend|
        Stew::Community::SteamId.should_receive(:new).with(friend['steamid'])
      end
      subject.entries.count.should eq 32
    end
  end
end