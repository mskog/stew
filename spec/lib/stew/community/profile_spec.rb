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
  end
end