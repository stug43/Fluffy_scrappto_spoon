require_relative "../lib/townhall_lister.rb"

describe "the perform_valdoiseversion method" do

	it "should return an array of hashs" do
expect(perform_valdoiseversion().size>50).to eq(true)
expect(perform_valdoiseversion().keys[7].class).to eq(String)

end

end
