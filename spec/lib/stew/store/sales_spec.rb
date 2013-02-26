# encoding: utf-8

require 'spec_helper'

describe Stew::Store::Sales do
  let(:response){File.new("spec/fixtures/store/sales/sales.txt").read}
  subject{Stew::Store::Sales.new(response)}

  describe "sales" do
    it "has the expected sales" do
      subject.entries.first.name.should eq "Call of Duty®: Black Ops II"
    end
  end
end