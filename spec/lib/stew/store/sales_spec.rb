# encoding: utf-8

require 'spec_helper'

describe Stew::Store::Sales do
  let(:response){File.new("spec/fixtures/store/sales/sales.txt").read}
  subject{Stew::Store::Sales.new(response)}
end