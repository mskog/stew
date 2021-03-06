require 'spec_helper'

describe "Stew::Store::WebClient", :vcr => {:cassette_name => 'web_client'} do
  let(:uri){'http://store.steampowered.com/'}

  subject{Stew::Store::WebClient.new(uri)}

  describe ".get" do
    let(:id){216390}

    context "without optional parameters" do
      it "performs a request to the given URL" do
        response = subject.get("app/#{id}")
        response.should include("http://store.steampowered.com/app/#{id}")
      end
    end

    context "with optional parameters" do
      it "performs a request to the given URL" do
        response = subject.get("app/#{id}", {:foo => :bar})
        response.should include("http://store.steampowered.com/app/#{id}")
      end
    end
  end
end