#encoding: utf-8

require 'spec_helper'

describe "Store", :vcr do
  describe "Creation of a store app with data" do
    subject{Stew::Store::App.new(211420)}

    it "sets the name" do
      subject.name.should eq "Dark Souls™: Prepare To Die™ Edition"
    end

    it "sets the score" do
      subject.score.should eq 85
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
  end

  describe "Creation of a store DLC app with data" do
    subject{Stew::Store::App.new(16870)}

    it "sets dlc flag" do
      subject.dlc?.should be_true
    end
  end

  describe "Creation of a store App with multiple offers" do
    subject{Stew::Store::App.new(49520)}

    it "has multiple offers" do
      subject.offers.size.should > 1
    end

    it "has a base price" do
      subject.price.should eq Money.parse("$59.99")
    end

    describe "the basic offer" do
      let(:offer){subject.offers.first}

      it "has the correct name" do
        offer.name.should eq 'Borderlands 2'
      end

      it "has no description" do
        offer.description.should be_nil
      end

      it "has the correct price" do
        offer.price.should eq Money.parse("$59.99")
      end
    end

    describe "the 4 pack" do
      let(:offer){subject.offers[1]}

      it "has the correct name" do
        offer.name.should eq 'Borderlands 2 - 4-Pack'
      end

      it "has the correct description" do
        offer.description.should eq "Includes four copies of Borderlands 2 - Send the extra copies to your friends"
      end

      it "has the correct price" do
        offer.price.should eq Money.parse("$179.99")
      end
    end
  end

  describe "Creation of a UK store app" do
    subject{Stew::Store::App.new(49520, {:region => :uk})}

    it "sets the correct price" do
      subject.price.currency.should eq Money::Currency.new 'GBP'
    end
  end

  describe "Creation of a EU1 store app" do
    subject{Stew::Store::App.new(49520, {:region => :se})}

    it "sets the correct currency" do
      subject.price.currency.should eq Money::Currency.new 'EUR'
    end
  end

  describe "Creation of a steam app from a URL" do
    let(:id){49520}
    let(:region){:se}
    let(:url){"http://store.steampowered.com/app/#{id}/?cc=#{region}"}

    it "creates the app" do
      Stew::Store::App.create(url).id.should eq id
    end
  end
end