require 'spec_helper'

describe Stew::Store::Sales, :focus do
  let(:response){File.new("spec/fixtures/store/sales/sales.txt").read}
  subject{Stew::Store::Sales.new(response)}

  it "something"
end