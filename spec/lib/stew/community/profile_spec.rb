require 'spec_helper'

describe "Stew::Community::Profile" do
  let(:id){76561197992917668}
  let(:response){YAML.load_file('spec/fixtures/profiles/76561197992917668.json')['response']['players'].first}

  subject{Stew::Community::Profile.new(response)}

  describe "attributes" do
    it "sets the id" do
      subject.id.should eq id
    end

    it "sets the nickname" do
      subject.nickname.should eq 'MrCheese'
    end

    it "sets the last_logoff" do
      subject.last_logoff.should eq Time.at 1366670468
    end

    it "sets the small avatar" do
      subject.avatar.small.should eq "http://media.steampowered.com/steamcommunity/public/images/avatars/3f/3fa6fcddcca7825ee0a77f4f4b8f4e10543a13cd.jpg"
    end

    it "sets the medium avatar" do
      subject.avatar.medium.should eq "http://media.steampowered.com/steamcommunity/public/images/avatars/3f/3fa6fcddcca7825ee0a77f4f4b8f4e10543a13cd_medium.jpg"
    end

    it "sets the large avatar" do
      subject.avatar.large.should eq "http://media.steampowered.com/steamcommunity/public/images/avatars/3f/3fa6fcddcca7825ee0a77f4f4b8f4e10543a13cd_full.jpg"
    end
  end
end