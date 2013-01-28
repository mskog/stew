#encoding: utf-8

require 'spec_helper'

describe Stew::Store::App do
  let(:response){open("spec/fixtures/store/apps/#{id}.txt")}
  let(:region){:us}
  let(:store_client) do
    client = double("store_client")
    client.stub(:app).with(id).and_return(response)
    client
  end

  subject{Stew::Store::App.new(id, {:region => :us, :client => store_client})}

  describe "#create" do
    let(:id){211420}

    context "when given an integer" do
      it "creates a steam_id with the given integer as id" do
        Stew::Store::App.should_receive(:new).with(id)
        Stew::Store::App.create(id)
      end
    end

    context "when given a url with a region" do
      let(:url){"http://store.steampowered.com/app/#{id}/?cc=#{region}"}

      it "creates an app" do
        Stew::Store::App.should_receive(:new).with(id.to_s, {:region => region.to_s})
        Stew::Store::App.create(url)
      end
    end

    context "when given a url without a region" do
      let(:url){"http://store.steampowered.com/app/#{id}"}

      it "creates an app" do
        Stew::Store::App.should_receive(:new).with(id.to_s)
        Stew::Store::App.create(url)
      end
    end

    context "when the given parameter cannot be matched" do
      let(:url){"sodijfsdf"}

      it "raises a Stew::Store::AppIdNotFoundError" do
        expect{Stew::Store::App.create(url)}.to raise_error(Stew::Store::AppIdNotFoundError)
      end
    end
  end


  describe ".initialize" do
    let(:id){211420}

    it "creates a store client with the correct region if none is given" do
      Stew::StoreClient.should_receive(:new).with(:uk).and_return(store_client)
      app = Stew::Store::App.new(id, {:region => :uk})
    end
  end

  describe "attributes" do
    let(:id){211420}

    describe ".name" do
      it "sets the name" do
        subject.name.should eq "Dark Souls™: Prepare To Die™ Edition"
      end
    end

    describe ".score" do
      context "when the app has a score" do
        it "sets the store" do
          subject.score.should eq 85
        end
      end

      context "when the app has no score" do
        let(:id){2290}

        it "sets the store to nil" do
          app = Stew::Store::App.new(id, {:client => store_client})
          app.score.should be_nil
        end
      end
    end

    describe ".release_date" do
      it "sets the release date" do
        subject.release_date.should eq Date.parse("Aug 23, 2012")
      end
    end

    describe ".dlc?" do
      context "when the app is not DLC" do
        it "returns false" do
          subject.dlc?.should be_false
        end
      end

      context "when the app is DLC" do
        let(:id){16870}

        it "returns true" do
          subject.dlc?.should be_true
        end
      end
    end

    describe ".developer" do
      it "returns the developer" do
        subject.developer.should eq 'FromSoftware'
      end
    end

    describe ".publisher" do
      it "returns the publisher" do
        subject.publisher.should eq 'Namco Bandai Games'
      end
    end

    describe ".indie?" do
      context "when the game is indie" do
        let(:id){219150}

        it "returns true" do
          subject.indie?.should be_true
        end
      end

      context "when the game is not indie" do
        it "returns false" do
          subject.indie?.should be_false
        end
      end
    end

    describe ".price" do
      it "returns the price of the first offer" do
        subject.price.should eq Money.new(3999,'EUR')
      end
    end

    describe "offers" do
      it "has the correct offers" do
        subject.offers.first.name.should eq 'Dark Souls™: Prepare To Die™ Edition'
      end

      it "has the correct description" do
        subject.offers.first.description.should be_nil
      end

      it "has the correct price" do
        subject.offers.first.price.should eq Money.new(3999,'EUR')
      end
    end
  end
end
