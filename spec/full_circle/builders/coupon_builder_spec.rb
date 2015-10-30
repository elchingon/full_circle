require 'spec_helper'

module FullCircle
  describe Builders::CouponBuilder do
    describe ".build" do
      it "returns a new Coupon object" do
        data = {
          "id"=>"32025",
          "name"=>"90 for 90!",
          "url"=>"90-for-90-",
          "begin"=>"2013-04-04",
          "expire"=>"2013-04-30",
          "accept_offline"=>"1",
          "accept_online"=>"0",
          "acceptMobile"=>"1",
          "acceptPrint"=>"0",
          "offer"=>"Get a relaxing and restorative 90 minute massage for just $90!",
          "restrictions"=>"Service must be booked in the month of April."
        }

        coupon = described_class.build data

        expected_coupon = Coupon.new id: 32025,
          name: "90 for 90!",
          path_segment: "90-for-90-",
          begin: Date.new(2013, 04, 04),
          expire: Date.new(2013, 04, 30),
          accept_offline: true,
          accept_online: false,
          accept_mobile: true,
          accept_print: false,
          offer: "Get a relaxing and restorative 90 minute massage for just $90!",
          restrictions: "Service must be booked in the month of April."

        expect(coupon).to eq(expected_coupon)
      end
    end
  end
end
