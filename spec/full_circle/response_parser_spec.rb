require "spec_helper"

describe FullCircle::ResponseParser do

  describe "#parse" do

    context "parsing events" do
      
      context "with one event" do

        it "returns an array of one event" do
          response_double = double("response")
          response_double.stub(:parsed_response) do
            {"ad_getEventsResponse" => {"events" => {"event" => 
              {"id" => "58794", :title => "TWO FOR ONE ENTREES"}
            }}}
          end


          results = described_class.parse response_double
          
          results.should be_a Array
          results.length.should == 1
          results.first.should be_a FullCircle::Event


        end

      end

      context "with multiple events" do

        it "returns an array of multiple events" do
          response_double = double("response")
          response_double.stub(:parsed_response) do
            {"ad_getEventsResponse" => {"events" => {"event" =>[ 
              {"id" => "58794", :title => "TWO FOR ONE ENTREES"},
              {"id" => "12345", :title => "Three FOR ONE ENTREES"}
            ]}}}
          end

          results = described_class.parse response_double
         
          results.should be_a Array
          results.length.should == 2
          results.first.should be_a FullCircle::Event
        end

      end

      context "with no events" do
        it "returns an emtpy array" do
          
          response_double = double("response")
          response_double.stub(:parsed_response) do
            {"ad_getEventsResponse" => {"events" => nil}}
          end

          results = described_class.parse response_double
         
          results.should eq []
        end
      end

    end 

  end

end
