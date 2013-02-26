# encoding: utf-8

require 'spec_helper'

describe Stew::Store::Sale do
  let(:response){File.new("spec/fixtures/store/sales/sale.txt").read}
  subject{Stew::Store::Sale.new(Nokogiri::HTML(response))}

  describe "#name" do
    let(:expected_name){"Tomb Raider"}

    it "returns the name" do
      subject.name.should eq expected_name
    end
  end

  describe "#price" do
    let(:expected_price){Money.new("4499", :usd)}

    it "returns the price" do
      subject.price.should eq expected_price
    end
  end

  describe "#original_price" do
    let(:expected_original_price){Money.new("4999", :usd)}

    it "returns the original price" do
      subject.original_price.should eq expected_original_price
    end
  end

  describe "#app_id" do
    let(:expected_app_id){203160}

    it "returns the app id" do
      subject.app_id.should eq expected_app_id
    end
  end
end