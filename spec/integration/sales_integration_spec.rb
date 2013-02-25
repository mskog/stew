#encoding: utf-8

require 'spec_helper'

describe "Sales" do
  before(:each) do
    raw_response_file = File.new("spec/fixtures/store/sales/sales.txt")
    stub_request(:get, "http://store.steampowered.com/search/tab?cc=se&l=english&tab=Discounts&start=0&count=10000").to_return(raw_response_file)
  end

  describe "parsing of the sales" do
    let(:subject){Stew::Store::SalesClient.new}
    let(:sales){subject.sales}

    it "has the correct name" do
      sales.first.name.should eq "Call of DutyÂ®: Black Ops II"
    end

    it "has the correct price" do
      sales.first.price.should eq Money.new('40,19', :eur)
    end

    it "has the correct original price" do
      sales.first.original_price.should eq Money.new('59,99', :eur)
    end

    it "has an app id" do
      sales.first.app_id.should eq 202970
    end
  end
end