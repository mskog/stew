require 'spec_helper'

describe "Stew::Community::XmlClient" do
  let(:uri){'http://steamcommunity.com'}
  let(:results){YAML.load_file("spec/fixtures/profiles/#{id}.yml")}
  let(:id){76561197992917668}

  subject{Stew::Community::XmlClient.new(uri)}

  describe "#get" do
    context "when no error is found in the reply" do
      let(:path){"/profiles/#{id}"}

      before :each do
        stub_request(:get, "http://steamcommunity.com/profiles/#{id}?xml=1").to_return(File.new("spec/fixtures/profiles/#{id}.txt"))
      end

      it "returns the response" do
        subject.get(path).should eq results
      end
    end

    context "when an error is found in the reply" do
      let(:id){"4d"}
      let(:path){"/profiles/#{id}"}

      before :each do
        stub_request(:get, "http://steamcommunity.com/profiles/#{id}?xml=1").to_return(File.new("spec/fixtures/profiles/#{id}.txt"))
      end

      it "throws an ObjectNotFound error" do
        expect{subject.get(path).should}.to raise_error(Stew::Community::XmlClient::ObjectNotFoundError)
      end
    end
  end
end