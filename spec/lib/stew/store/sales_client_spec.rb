require 'spec_helper'

describe "Stew::Store::SalesClient" do
  let(:client){double('sales_client')}
  let(:response){open("spec/fixtures/store/sales/sales.txt")}
  let(:region){:se}
  subject{Stew::Store::SalesClient.new({:client => client})}

  describe "sales" do
    it "sends the correct message to it's client" do
      expected_options = {:cc => region, :l => 'english', :tab => 'Discounts', :start => 0, :count => 10000}
      client.should_receive(:get).with("/search/tab", expected_options).and_return(response)
      Stew::Store::Sales.should_receive(:new).with(response)
      subject.sales
    end
  end
end