require_relative "../lib/bitcoins_lister.rb"

describe "the perform method" do
	it "should return an array of hashs" do
expect(perform().size>50).to eq(true)
expect(perform().keys[7].class).to eq(String)
end
end
