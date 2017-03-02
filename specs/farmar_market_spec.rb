require_relative 'spec_helper'
require_relative '../lib/farmar_market.rb'

describe "FarMar::Market class" do
  it "is a class" do
    new_market = FarMar::Market.new({})
    new_market.must_be_instance_of Market
  end

  describe "initialize" do
    it "raises an error if passed a non hash object" do

    end
  end

  describe "self.all" do

    it "returns array" do

    end

    it "array contains only Market objects" do

    end

    it "Market objects respond to appropriate attributes" do

    end

  end

  describe "find.all" do

    it "given an id, finds the market object that has that id" do

    end

    it "returns a Market object" do

    end

    it "raises an error if passed a non-integer" do

    end

  end

  describe "vendors" do

    it "" do

    end

  end

end
