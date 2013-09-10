require 'spec_helper'

describe "Community Access through the Web API", :vcr do
  describe "Number of Current Players" do
    subject{Stew::Community::UserStats.new}

    describe "#number_of_current_players" do
      let(:app_id){570}
      
      it "returns the number of players" do
        subject.number_of_current_players(app_id).should > 0
      end
    end
  end
end