require 'spec_helper'

describe "Parsing of broken sales", :vcr do
  before(:each) do
    raw_response_file = File.new("spec/fixtures/store/sales/broken_sales.txt")
    stub_request(:get, "http://store.steampowered.com/search/tab?cc=us&l=english&tab=Discounts&start=0&count=10000").to_return(raw_response_file)
  end

  describe "parsing of the sales" do
    let(:subject){Stew::Store::SalesClient.new}
    let(:sales){subject.sales}

    it "handles responses with no original price" do
      sales.each(&:original_price)
    end
  end
end