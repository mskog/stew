require 'spec_helper'

describe Stew::Community::SteamIdResolver, :focus do
  let(:client){double}
  subject{Stew::Community::SteamIdResolver.new(client)}

  describe ".initialize" do
    context "when given a client" do
      let(:client){double}

      it "sets the client" do
        Stew::Community::SteamIdResolver.new(client).client.should eq client
      end
    end

    context "with no client given" do
      it "creates a new default client" do
        Stew::Community::WebApiClient.should_receive(:new)
        Stew::Community::SteamIdResolver.new
      end
    end
  end

  describe ".steam_id" do
    context "when the given data is a number" do
      let(:data){"12345"}
      let(:expected_steam_id){12345}

      it "returns the number" do
        subject.steam_id(data).should eq expected_steam_id
      end
    end

    context "when the given data is a vanity name" do
      let(:data){'foobar20'}
      let(:expected_steam_id){12345}

      it "resolves the vanity name and sets the id" do
        client.should_receive(:vanity_url_to_steam_id).with(data).and_return(expected_steam_id)
        subject.steam_id(data).should eq expected_steam_id
      end
    end

    context "when the given data is a vanity url" do
      let(:data){'steamcommunity.com/id/foobar20'}
      let(:expected_steam_id){12345}

      it "resolves the vanity url and sets the id" do
        client.should_receive(:vanity_url_to_steam_id).with(data).and_return(expected_steam_id)
        subject.steam_id(data).should eq expected_steam_id
      end
    end

    context "when the given data is a steamcommunity url" do
      let(:data){'steamcommunity.com/profiles/12345'}
      let(:expected_steam_id){12345}

      it "extracts the id from the url and sets the id" do
        subject.steam_id(data).should eq expected_steam_id
      end
    end

    context "when the given data is a steamcommunity url with extra at the end" do
      let(:data){'steamcommunity.com/profiles/12345/friends'}
      let(:expected_steam_id){12345}

      it "extracts the id from the url and sets the id" do
        subject.steam_id(data).should eq expected_steam_id
      end
    end

    context "when no steam id can be found or resolved from the string" do
      let(:data){'foobar'}
      let(:expected_steam_id){12345}

      it "returns nil" do
        client.should_receive(:vanity_url_to_steam_id).with(data).and_return(nil)
        subject.steam_id(data).should be_nil
      end
    end
  end
end