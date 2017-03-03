require_relative 'spec_helper'
require_relative '../lib/farmar_product.rb'

describe "FarMar::Product class" do
  it "is an instance of FarMar::Product" do
    new_product = FarMar::Product.new({})
    new_product.must_be_instance_of FarMar::Product
  end

  describe "initialize" do
    it "raises an error if passed a non hash object" do
      wrong_objects = [3, "string", [], nil]
      wrong_objects.each do |object|
        proc{FarMar::Product.new(object)}.must_raise ArgumentError
      end
    end
  end

  describe "self.all" do

    it "returns array" do
      FarMar::Product.all.must_be_kind_of Array
    end

    it "array contains only Product objects" do
      all_products = FarMar::Product.all
      all_products.each do |product|
        product.must_be_instance_of FarMar::Product
      end
    end

    it "Product objects respond to appropriate attributes" do
      all_products = FarMar::Product.all
      all_products.each do |product|
        product.must_respond_to :id
        product.must_respond_to :name
        product.must_respond_to :vendor_id
      end
    end

  end

  describe "self.find" do
    it "raises an error if passed a non-integer" do
      proc {FarMar::Product.find("pooky")}.must_raise ArgumentError
    end

    it "errors out if given an id that doesn't exist" do
      proc {FarMar::Product.find(999999)}.must_raise ArgumentError
    end

    it "returns an instance of Product" do
      test_product = FarMar::Product.find(6)
      test_product.must_be_kind_of FarMar::Product
    end

    it "given an id, finds the market object that has that id" do
      test_product = FarMar::Product.find(2)
      test_product.name.must_equal "Fierce Greens"
    end

  end

  describe "self.by_vendor" do

    it "raise arg error if passed in non-integer" do
      wrong_objects = [{}, "string", [], nil]
      wrong_objects.each do |object|
        proc{FarMar::Product.by_vendor(object)}.must_raise ArgumentError
      end
    end

    it "returns an array" do
      FarMar::Product.by_vendor(100).must_be_kind_of Array
    end

    it "each element in the array is a Product object" do
      all_associated_vendors = FarMar::Product.by_vendor(4)
      all_associated_vendors.each do |vendor|
        vendor.must_be_instance_of FarMar::Product
      end
    end

    it "each element in the array has the same vendor_id as was passed in" do
      test_id = 10
      associated_products = FarMar::Product.by_vendor(test_id)
      associated_products.each do |product|
        product.vendor_id.must_equal test_id
      end
    end
  end

  describe "vendor" do

    it "returns a Vendor object" do
      FarMar::Product.new({id: 1, name: "Dry Beets", vendor_id: 1}).vendor.must_be_instance_of FarMar::Vendor
    end

    it "Vendor id matches current Product vendor_id" do
      product = FarMar::Product.new({id: 1, name: "Dry Beets", vendor_id: 1})
      vendor = product.vendor
      vendor.id.must_equal product.vendor_id
    end

    it "raise error if no vendor found" do
      proc {FarMar::Product.new({id: 1, name: "Dry Beets", vendor_id: -1}).vendor}.must_raise ArgumentError
    end

  end

  describe "sales" do

    it "returns an array" do
      FarMar::Product.new({id: 1, name: "Dry Beets", vendor_id: 1}).sales.must_be_kind_of Array
    end

    it "array must contain Sale objects" do
      product = FarMar::Product.new({id: 1, name: "Dry Beets", vendor_id: 1})
      sales = product.sales
      sales.each do |sale|
        sale.must_be_instance_of FarMar::Sale
      end
    end

    it "each sale object must have the product_id matching the current Product object" do
      product = FarMar::Product.new({id: 1, name: "Dry Beets", vendor_id: 1})
      sales = product.sales
      sales.each do |sale|
        sale.product_id.must_equal 1
      end
    end

    it "raise arg error if no sales found" do
      proc {FarMar::Product.new({id: -1, name: "Dry Beets", vendor_id: 1}).sales}.must_raise ArgumentError
    end

  end

  describe "number_of_sales" do

    it "returns an integer" do
      FarMar::Product.new({id: 1, name: "Dry Beets", vendor_id: 1}).number_of_sales.must_be_kind_of Integer
    end

    it "finds all sales associated with a product" do
      product = FarMar::Product.new({id: 1, name: "Dry Beets", vendor_id: 1})
      all_sales = product.sales
      all_sales.length.must_equal 7
      product.number_of_sales.must_equal 7
    end

  end

end
