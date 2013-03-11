#encoding: utf-8

require 'spec_helper'

describe "Store", :vcr => {:cassette_name => 'store_integration'} do

  let(:store_client){Stew::Store::StoreClient.new}
  subject{store_client.app(id)}

  describe "Creation of a store app with data" do
    let(:id){211420}

    it "sets the name" do
      subject.name.should eq "Dark Souls™: Prepare To Die™ Edition"
    end

    it "sets the score" do
      subject.score.should be_a(Integer)
    end

    it "sets the release date" do
      subject.release_date.should eq Date.parse("Aug 23, 2012")
    end

    it "sets dlc flag" do
      subject.dlc?.should be_false
    end

    it "sets the genres" do
      subject.genres.should eq ['Action','RPG']
    end

    it "sets the developer" do
      subject.developer.should eq 'FromSoftware'
    end

    it "sets the publisher" do
      subject.publisher.should eq 'Namco Bandai Games'
    end

    it "is not indie" do
      subject.indie?.should be_false
    end

    it "sets the header image" do
      subject.header_image.should match /http:\/\/cdn.\.steampowered.com\/v\/gfx\/apps\/211420\/header_292x136\.jpg/
    end
  end

  describe "Creation of a store DLC app with data" do
    let(:id){16870}

    subject{store_client.app(id)}

    it "sets dlc flag" do
      subject.dlc?.should be_true
    end
  end

  describe "Creation of a store App with multiple offers" do
    let(:id){49520}
    subject{store_client.app(id)}

    it "has multiple offers" do
      subject.offers.count.should > 1
    end

    it "has a base price" do
      subject.price.currency.should eq Money.parse("$59.99").currency
    end

    describe "the basic offer" do
      let(:offer){subject.offers.first}

      it "has the correct name" do
        offer.name.should eq 'Borderlands 2'
      end

      it "has no description" do
        offer.description.should be_nil
      end

      it "has the correct currency" do
        offer.price.currency.should eq Money.parse("$59.99").currency
      end
    end
  end

  describe "Creation of a UK store app" do
    subject{store_client.app(49520, :uk)}

    it "sets the correct price" do
      subject.price.currency.should eq Money::Currency.new 'GBP'
    end
  end

  describe "Creation of a EU1 store app" do
    subject{store_client.app(49520, :se)}

    it "sets the correct currency" do
      subject.price.currency.should eq Money::Currency.new 'EUR'
    end
  end

  describe "Creation of an app from a url" do
    let(:url){"http://store.steampowered.com/app/205100/?cc=uk"}
    subject{store_client.create_app(url)}

    it "has the correct currency" do
      subject.price.currency.should eq Money::Currency.new 'GBP'
    end

    it "has the correct name" do
      subject.name.should eq 'Dishonored'
    end
  end
end