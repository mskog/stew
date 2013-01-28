require 'spec_helper'

describe "Stew::StoreClient" do
  let(:client){double('web_client')}
  let(:response){open("spec/fixtures/store/apps/#{id}.txt")}
  let(:region){:us}
  subject{Stew::StoreClient.new(region,client)}

  describe ".app" do
    let(:id) {211420}
    it "sends the correct message to its client" do
      client.should_receive(:get).with("/app/#{id}", {:cc => region}).and_return(response)
      subject.app(id)
    end
  end
end