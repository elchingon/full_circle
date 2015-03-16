require "spec_helper"
require 'ostruct'

describe FullCircle::ResponseBuilder do
  let(:object_builder_double) do
    instance_double("FullCircle::ObjectBuilder", from_api_hash: nil)
  end

  describe "#build" do
    context "with empty array of api_results" do

      it "calls object_builder.from_api_hash" do
        subject.build [], object_builder: object_builder_double

        expect(object_builder_double).not_to have_received(:from_api_hash)
      end

    end

    context "with an array of multiple api_results" do

      it "calls object_builder.from_api_hash" do
        subject.build [{},{}], object_builder: object_builder_double

        expect(object_builder_double).to have_received(:from_api_hash).with({}).exactly(2).times
      end
    end

    describe "response outgoing messages" do

      it "creates a response with the correct arguments" do
        expect(FullCircle::Response).to receive(:new).with([nil,nil])

        subject.build [{},{}], object_builder: object_builder_double
      end
    end

  end

end
