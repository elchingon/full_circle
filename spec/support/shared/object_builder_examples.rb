shared_examples_for "an object builder" do
  it {should respond_to(:from_api_hash).with(1).argument}
end
