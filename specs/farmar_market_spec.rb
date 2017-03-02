require_relative 'spec_helper'
require_relative '../lib/farmar_market.rb'

describe "FarMar::Market class" do
  it "is a class" do
    new_market = FarMar::Market.new({})
    new_market.must_be_instance_of FarMar::Market
  end

  describe "initialize" do
    it "raises an error if passed a non hash object" do
      wrong_objects = [3, "string", [], nil]
      wrong_objects.each do |object|
        proc{FarMar::Market.new(object)}.must_raise ArgumentError
      end
    end
  end

  describe "self.all" do

    it "returns array" do
      FarMar::Market.all.must_be_kind_of Array
    end

    it "array contains only Market objects" do
      all_markets = FarMar::Market.all
      all_markets.each do |market|
        market.must_be_instance_of FarMar::Market
      end
    end

    it "Market objects respond to appropriate attributes" do
      all_markets = FarMar::Market.all
      all_markets.each do |market|
        market.must_respond_to :id
        market.must_respond_to :name
        market.must_respond_to :address
        market.must_respond_to :city
        market.must_respond_to :county
        market.must_respond_to :state
        market.must_respond_to :zip
      end
    end

  end

  describe "self.find" do
    it "raises an error if passed a non-integer" do
      proc {FarMar::Market.find("pooky")}.must_raise ArgumentError
    end

    it "errors out if given an id that doesn't exist" do
      proc {FarMar::Market.find(999999)}.must_raise ArgumentError
    end

    it "returns an instance of Market" do
      test_market = FarMar::Market.find(6)
      test_market.must_be_kind_of FarMar::Market
    end

    it "given an id, finds the market object that has that id" do
      test_market = FarMar::Market.find(2)
      test_market.name.must_equal "Silverdale Farmers Market"
    end

  end

  describe "vendors" do
    before do
      @market = FarMar::Market.new({id: 1,name: "People's Co-op Farmers Market",address: "30th and Burnside",city: "Portland",county: "Multnomah",state: "Oregon",zip: "97202"})
    end

    it "should return array" do
      @market.vendors.must_be_kind_of Array
    end

    it "array should contain only Vendor objects" do
      vendors_array = @market.vendors
      vendors_array.each do |vendor|
        vendor.must_be_instance_of Vendor
      end
    end

    it "each Vendor object's market_id should match the Market object's id" do
      vendors_array = @market.vendors
      vendors_array.each do |vendor|
        @market.id.must_equal vendor.id
      end

    end

  end

end
