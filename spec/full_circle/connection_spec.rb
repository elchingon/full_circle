require "spec_helper"

describe FullCircle::Connection do

  it "should set domain when set in the constructor" do
    ds = FullCircle::Connection.new "360durango.com"
    ds.domain.should eq "360durango.com"
  end

  it "should set base_uri based on the domain attribute" do
    ds = FullCircle::Connection.new "360durango.com"
    ds.base_uri.should eq "http://api.360durango.com/1.0/"

  end

end
