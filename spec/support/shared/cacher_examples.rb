shared_examples_for "a cacher" do
  it { expect(subject).to respond_to(:fetch).with(1).argument }

  describe "#store" do
    it "returns the value that is stored" do
      expect(subject.store("key","value")).to eq("value")
    end
  end
end
