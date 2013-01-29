#encoding: utf-8

require 'spec_helper'

describe Stew::Store::App do
  let(:response){open("spec/fixtures/store/apps/#{id}.txt")}

  subject{Stew::Store::App.new(response)}

  describe "attributes" do
    context "when the parse is successful" do
      let(:id){211420}

      describe ".name" do
        it "sets the name" do
          subject.name.should eq "Dark Souls™: Prepare To Die™ Edition"
        end
      end

      describe ".score" do
        context "when the app has a score" do
          it "sets the store" do
            subject.score.should eq 85
          end
        end

        context "when the app has no score" do
          let(:id){2290}

          it "sets the store to nil" do
            subject.score.should be_nil
          end
        end
      end

      describe ".release_date" do
        it "sets the release date" do
          subject.release_date.should eq Date.parse("Aug 23, 2012")
        end
      end

      describe ".dlc?" do
        context "when the app is not DLC" do
          it "returns false" do
            subject.dlc?.should be_false
          end
        end

        context "when the app is DLC" do
          let(:id){16870}

          it "returns true" do
            subject.dlc?.should be_true
          end
        end
      end

      describe ".developer" do
        it "returns the developer" do
          subject.developer.should eq 'FromSoftware'
        end
      end

      describe ".publisher" do
        it "returns the publisher" do
          subject.publisher.should eq 'Namco Bandai Games'
        end
      end

      describe ".indie?" do
        context "when the game is indie" do
          let(:id){219150}

          it "returns true" do
            subject.indie?.should be_true
          end
        end

        context "when the game is not indie" do
          it "returns false" do
            subject.indie?.should be_false
          end
        end
      end

      describe ".price" do
        it "returns the price of the first offer" do
          subject.price.should eq Money.new(3999,'EUR')
        end
      end

      describe "offers" do
        it "has the correct offers" do
          subject.offers.first.name.should eq 'Dark Souls™: Prepare To Die™ Edition'
        end

        it "has the correct description" do
          subject.offers.first.description.should be_nil
        end

        it "has the correct price" do
          subject.offers.first.price.should eq Money.new(3999,'EUR')
        end
      end
    end

    context "when the parse is unsuccessful" do
      let(:id){"no_app"}

      %w(name score release_date developer publisher).each do |attribute|
        describe ".#{attribute}" do
          it "should be nil" do
            subject.send(attribute).should be_nil
          end
        end
      end

      describe ".genres" do
        it "should return an empty array" do
          subject.genres.should eq []
        end
      end
    end
  end
end
