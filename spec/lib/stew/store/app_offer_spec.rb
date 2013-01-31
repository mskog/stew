require 'spec_helper'

describe "Stew::Store::AppOffer" do
  let(:name){'Borderlands 2'}
  let(:description){'Includes four copies of Borderlands 2 - Send the extra copies to your friends'}
  let(:price){Money.new(4999,'EUR')}

  let(:node){Nokogiri.HTML(open("spec/fixtures/store/apps/49520_offers.txt"))}

  subject{Stew::Store::AppOffer.new(node)}

  describe ".create" do
    context "when the app is not on sale" do
      it "returns an AppOffer instance" do
        Stew::Store::AppOffer.create(node).should be_a(Stew::Store::AppOffer)
      end
    end

    context "when the app is on sale" do
      let(:node){Nokogiri.HTML(open("spec/fixtures/store/apps/211400_offers_sale.txt"))}

      it "returns an AppOfferSale instance" do
        Stew::Store::AppOffer.create(node).should be_a(Stew::Store::AppOfferSale)
      end
    end
  end

  describe "attributes" do
    it "sets the name" do
      subject.name.should eq name
    end

    it "sets the description" do
      subject.description.should eq description
    end

    it "sets the price" do
      subject.price.should eq price
    end
  end

  describe ".sale?" do
    it "is false" do
      subject.sale?.should be_false
    end
  end
end