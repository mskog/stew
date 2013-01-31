require 'spec_helper'

describe "Stew::Store::AppOffers" do
  let(:file_name){"49520_offers"}
  let(:node){Nokogiri.HTML(open("spec/fixtures/store/apps/#{file_name}.txt"))}

  subject{Stew::Store::AppOffers.new(node)}

  describe ".entries" do
    it "sets the app offers" do
      node.css("div.game_area_purchase_game").each do |item|
        Stew::Store::AppOffer.should_receive(:create).with(item)
      end
      Stew::Store::AppOffers.new(node)
    end

    it "has the correct amount of offers" do
      subject.count.should eq 4
    end

    it "has offers" do
      subject.each do |offer|
        offer.should be_a(Stew::Store::AppOffer)
      end
    end
  end

  describe ".sale?" do
    context "when the app has no sale" do
      it "returns false" do
        subject.sale?.should be_false
      end
    end

    context "when the app has a sale" do
      let(:file_name){"211400_offers_sale"}
      it "returns true" do
        subject.sale?.should be_true
      end
    end
  end

  describe ".sales" do
    context "when the app has no sale" do
      it "returns an empty array" do
        subject.sales.should eq []
      end
    end

    context "when the app is on sale" do
      let(:file_name){"211400_offers_sale"}

      it "returns an array of the AppOffers on sale" do
        subject.sales.count.should eq 2
      end

      it "returns an array of AppOfferSale objects" do
        subject.sales.each do |app_offer|
          app_offer.should be_a(Stew::Store::AppOfferSale)
        end
      end
    end
  end
end