require 'spec_helper'

describe "Stew::Community::UserStats" do
  let(:client){double('client')}

  subject{Stew::Community::UserStats.new(client: client)}

  describe ".number_of_current_players" do
    let(:app_id){570}

    it "returns the data received from the client" do
      client.should_receive(:number_of_current_players).and_return(400)
      subject.number_of_current_players(app_id).should eq 400
    end
  end
end