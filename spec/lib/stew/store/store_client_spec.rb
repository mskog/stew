require 'spec_helper'

describe "Stew::Store::StoreClient" do
  let(:client){double('web_client')}
  let(:response){open("spec/fixtures/store/apps/#{id}.txt")}
  let(:region){:us}
  subject{Stew::Store::StoreClient.new({:client => client})}

  describe ".app" do
    let(:id) {211420}
    it "sends the correct message to its client" do
      client.should_receive(:get).with("/app/#{id}", {:cc => region}).and_return(response)
      Stew::Store::App.should_receive(:new).with(response, id)
      subject.app(id)
    end
  end

  describe "#create_app" do
    let(:id){211420}

    context "when given an integer" do
      it "creates an app with the given integer as id" do
        client.stub(:get).with("/app/#{id}", {:cc => :us}).and_return(response)
        Stew::Store::App.should_receive(:new).with(response, id)
        subject.create_app(id)
      end
    end

    context "when given a url with a region" do
      let(:region){:uk}
      let(:url){"http://store.steampowered.com/app/#{id}/?cc=#{region}"}

      it "creates an app" do
        client.stub(:get).with("/app/#{id}", {:cc => region}).and_return(response)
        Stew::Store::App.should_receive(:new).with(response, id)
        subject.create_app(url)
      end
    end

    context "when given a url without a region" do
      let(:url){"http://store.steampowered.com/app/#{id}"}

      it "creates an app" do
        client.stub(:get).with("/app/#{id}", {:cc => :us}).and_return(response)
        Stew::Store::App.should_receive(:new).with(response, id)
        subject.create_app(url)
      end
    end

    context "when the given parameter cannot be matched" do
      let(:url){"sodijfsdf"}

      it "raises a Stew::Store::AppIdNotFoundError" do
        expect{subject.create_app(url)}.to raise_error(Stew::Store::AppIdNotFoundError)
      end
    end
  end
end