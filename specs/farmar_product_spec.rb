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

  describe "self.between" do

    it "" do

    end

  end

  describe "vendor" do

    it "" do

    end

  end

  describe "sales" do

    it "" do

    end

  end

  describe "number_of_sales" do

    it "" do

    end

  end

end
