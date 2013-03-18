require "spec_helper"

describe FullCircle::CouponBuilder do

  describe "#from_api_hash" do
    it "builds a new coupon with the appropriate attribute set" do
      coupon = described_class.from_api_hash("id" => "123", "name" => "Hello World")
      coupon.id.should eq "123"
      coupon.name.should eq "Hello World"
    end
    
    it "builds a new coupon with camelcased attributes converted to underscored attributes" do
      coupon = described_class.from_api_hash("acceptMobile" => "1")
      coupon.accept_mobile.should eq "1"
    end

  end
end
