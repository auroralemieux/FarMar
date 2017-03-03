require_relative 'spec_helper'
require_relative '../lib/farmar_vendor.rb'

describe "FarMar::Vendor class" do
  it "is a class" do
    new_vendor = FarMar::Vendor.new({})
    new_vendor.must_be_instance_of FarMar::Vendor
  end

  describe "initialize" do
    it "raises an error if passed a non hash object" do
      wrong_objects = [3, "string", [], nil]
      wrong_objects.each do |object|
        proc{FarMar::Vendor.new(object)}.must_raise ArgumentError
      end
    end
  end

  describe "self.all" do

    it "returns array" do
      FarMar::Vendor.all.must_be_kind_of Array
    end

    it "array contains only Vendor objects" do
      all_vendors = FarMar::Vendor.all
      all_vendors.each do |vendor|
        vendor.must_be_instance_of FarMar::Vendor
      end
    end

    it "Vendor objects respond to appropriate attributes" do
      all_vendors = FarMar::Vendor.all
      all_vendors.each do |vendor|
        vendor.must_respond_to :id
        vendor.must_respond_to :name
        vendor.must_respond_to :num_of_employees
        vendor.must_respond_to :market_id
      end
    end

  end

  describe "self.find" do
    it "raises an error if passed a non-integer" do
      proc {FarMar::Vendor.find("pooky")}.must_raise ArgumentError
    end

    it "errors out if given an id that doesn't exist" do
      proc {FarMar::Vendor.find(999999)}.must_raise ArgumentError
    end

    it "returns an instance of Vendor" do
      test_vendor = FarMar::Vendor.find(2)
      test_vendor.must_be_kind_of FarMar::Vendor
    end

    it "given an id, finds the market object that has that id" do
      test_vendor = FarMar::Vendor.find(6)
      test_vendor.name.must_equal "Zulauf and Sons"
    end

  end

  describe "market" do
    it "raises error if no id matches" do
      vendor = FarMar::Vendor.new({id: -14,name: "Stracke Group", num_of_employees: 2, market_id: -1})
      proc {vendor.market}.must_raise ArgumentError
    end
  end

  describe "products" do
    it "returns an array" do
      vendor = FarMar::Vendor.new({id: 14,name: "Stracke Group", num_of_employees: 2, market_id: 4})
      vendor.products.must_be_kind_of Array
    end

    it "objects in array are Products" do
      vendor = FarMar::Vendor.new({id: 14, name: "Stracke Group", num_of_employees: 2, market_id: 4})
      related_products = vendor.products
      related_products.each do |product|
        product.must_be_instance_of FarMar::Product
      end

    end

  end

  describe "sales" do
    it "returns an array" do
      vendor = FarMar::Vendor.new({id: 14,name: "Stracke Group", num_of_employees: 2, market_id: 4})
      vendor.sales.must_be_kind_of Array
    end

    it "objects in array are Sales" do
      skip
      vendor = FarMar::Vendor.new({id: 14, name: "Stracke Group", num_of_employees: 2, market_id: 4})
      related_sales = vendor.sales
      related_sales.each do |sale|
        sale.must_be_instance_of FarMar::Sale
      end

    end
  end

  describe "revenue" do
    it "" do

    end
  end

  describe "self.by_market" do
    it "" do

    end
  end

end
