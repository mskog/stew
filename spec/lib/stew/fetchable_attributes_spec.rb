require 'spec_helper'

describe "Stew::FetchableAttributes" do
  let(:expected_id){2}

  let(:klass){
    Class.new do
      include Stew::FetchableAttributes

      attr_reader_fetchable :id

      def fetch
        @id = 2
      end
    end
  }

  describe "attr_fetchable" do
    subject{klass.new}

    context "when @id is nil" do
      it "calls fetch" do
        subject.should_receive(:fetch)
        subject.id
      end

      it "returns @id" do
        subject.id.should eq expected_id
      end
    end

    context "when the @id not nil" do
      it "does not call fetch" do
        subject.instance_eval do 
          @id = 2
        end
        subject.should_receive(:fetch).never
        subject.id
      end

      it "returns @id" do
        subject.id.should eq expected_id
      end
    end
  end
end