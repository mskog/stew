require 'spec_helper'

describe "Stew::Store::AppOffer" do
  let(:name){'Borderlands 2'}
  let(:description){'Includes four copies of Borderlands 2 - Send the extra copies to your friends'}
  let(:price){Money.new(4999,'EUR')}

  let(:node){Nokogiri.HTML(open("spec/fixtures/store/apps/49520_offers.txt"))}

  subject{Stew::Store::AppOffer.new(node)}

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
end