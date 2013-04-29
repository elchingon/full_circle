shared_examples_for "a cacher" do
  it {should respond_to(:fetch).with(1).argument}

  describe "#store" do
    it "should return the value that is stored" do
      subject.store("key","value").should eq "value"
    end
  end
end
