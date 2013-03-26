require "spec_helper"

describe FullCircle::ResponseParser do

  describe "#parse" do

    
    context "parsing coupons" do

      let(:parser) {described_class.new "ad.getCoupons","coupon"}
      
      context "with one coupon" do
        it "returns an array of one coupon" do
          response_double = double("response")
          response_double.stub(:parsed_response) do
            {"ad_getCouponsResponse" => {"coupons" => {"coupon" => 
              {"id" => "58794", :name => "Early Bird Discount"}
            }}}
          end


          results = parser.parse response_double
          
          results.should be_a Array
          results.length.should == 1
          results.first.should be_a FullCircle::Coupon


        end
      end

      context "with multiple coupons" do
        it "returns an array of multiple coupons" do
          response_double = double("response")
          response_double.stub(:parsed_response) do
            {"ad_getCouponsResponse" => {"coupons" => {"coupon" =>[ 
              {"id" => "58794", :name => "TWO FOR ONE ENTREES"},
              {"id" => "12345", :name => "Three FOR ONE ENTREES"}
            ]}}}
          end

          results = parser.parse response_double
         
          results.should be_a Array
          results.length.should == 2
          results.first.should be_a FullCircle::Coupon
        end
      end

      context "with no coupons" do
        it "returns an empty array" do
          response_double = double("response")
          response_double.stub(:parsed_response) do
            {"ad_getCouponsResponse" => {"coupons" => nil}}
          end

          results = parser.parse response_double
         
          results.should eq []
        end
      end
    end

    context "parsing events" do
      
      let(:parser) {described_class.new "ad.getEvents","event"}
      
      context "with one event" do

        it "returns an array of one event" do
          response_double = double("response")
          response_double.stub(:parsed_response) do
            {"ad_getEventsResponse" => {"events" => {"event" => 
              {"id" => "58794", :title => "TWO FOR ONE ENTREES"}
            }}}
          end


          results = parser.parse response_double
          
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

          results = parser.parse response_double
         
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

          results = parser.parse response_double
         
          results.should eq []
        end
      end

    end 

    context "parsing event areas" do
      
      let(:parser) {described_class.new "city.getEventAreas","eventArea"}
      
      context "with one event areas" do

        it "returns an array of one event area" do
          response_double = double("response")
          response_double.stub(:parsed_response) do
            {"city_getEventAreasResponse" => {"eventAreas" => {"eventArea" => 
              {"id" => "736", :title => "Bayfield"}
            }}}
          end


          results = parser.parse response_double
          
          results.should be_a Array
          results.length.should == 1
          results.first.should be_a FullCircle::EventArea


        end

      end

      context "with multiple event areas" do

        it "returns an array of multiple event areas" do
          response_double = double("response")
          response_double.stub(:parsed_response) do
            {"city_getEventAreasResponse" => {"eventAreas" => {"eventArea" =>[ 
              {"id" => "58794", :title => "Bayfield"},
              {"id" => "12345", :title => "Vallecito"}
            ]}}}
          end

          results = parser.parse response_double
         
          results.should be_a Array
          results.length.should == 2
          results.first.should be_a FullCircle::EventArea
        end

      end

      context "with no event areas" do
        it "returns an emtpy array" do
          
          response_double = double("response")
          response_double.stub(:parsed_response) do
            {"city_getEventAreasResponse" => {"eventAreas" => nil}}
          end

          results = parser.parse response_double
         
          results.should eq []
        end
      end

    end 

  end

end
