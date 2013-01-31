require 'spec_helper'

describe "Stew::Store::AppOfferSale" do
  let(:price){Money.new(599,'EUR')}
  let(:regular_price){Money.new(1199,'EUR')}
  let(:name){"Deadlight"}

  let(:node){Nokogiri.HTML(open("spec/fixtures/store/apps/211400_offers_sale.txt"))}

  subject{Stew::Store::AppOfferSale.new(node)}

  describe "attributes" do
    it "sets the name" do
      subject.name.should eq name
    end

    it "sets the description to nil" do
      subject.description.should be_nil
    end

    it "sets the price" do
      subject.price.should eq price
    end

    it "sets the regular_price" do
      subject.regular_price.should eq regular_price
    end
  end

  describe ".sale?" do
    it "is true" do
      subject.sale?.should be_true
    end
  end

end