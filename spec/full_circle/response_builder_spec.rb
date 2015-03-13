require "spec_helper"
require 'ostruct'

describe FullCircle::ResponseBuilder do
  let(:object_builder_double) do
    class ObjectBuilderDouble
      def from_api_hash(arg)
      end
    end
    ObjectBuilderDouble.new
  end

  describe "object_builder_double" do
    subject {object_builder_double}
    it_behaves_like "an object builder"
  end

  describe "#build" do
    context "with empty array of api_results" do
      subject{ described_class.new [], object_builder: object_builder_double }

      it "calls object_builder.from_api_hash" do
        expect(object_builder_double).not_to receive(:from_api_hash)
        subject.build
      end

    end

    context "with an array of multiple api_results" do
      subject{ described_class.new [{},{}], object_builder: object_builder_double }

      it "calls object_builder.from_api_hash" do
        expect(object_builder_double).to receive(:from_api_hash).with({}).exactly(2).times
        subject.build
      end
    end

    describe "response outgoing messages" do
      subject{ described_class.new [{},{}], object_builder: object_builder_double }

      it "creates a response with the correct arguments" do
        expect(FullCircle::Response).to receive(:new).with([nil,nil],{})

        subject.build
      end
    end

  end

end
