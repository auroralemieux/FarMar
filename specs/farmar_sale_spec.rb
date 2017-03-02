require_relative 'spec_helper'
require_relative '../lib/farmar_sale.rb'

describe "FarMar::Sale class" do
  it "is a class" do
    new_sale = FarMar::Sale.new({})
    new_sale.must_be_instance_of FarMar::Sale
  end


  describe "initialize" do
    it "raises an error if passed a non hash object" do
      wrong_objects = [3, "string", [], nil]
      wrong_objects.each do |object|
        proc{FarMar::Sale.new(object)}.must_raise ArgumentError
      end
    end
  end

  describe "self.all" do

    it "returns array" do
      FarMar::Sale.all.must_be_kind_of Array
    end

    it "array contains only Sale objects" do
      all_sales = FarMar::Sale.all
      all_sales.each do |sale|
        sale.must_be_instance_of FarMar::Sale
      end
    end

    it "Sale objects respond to appropriate attributes" do
      all_sales = FarMar::Sale.all
      all_sales.each do |sale|
        sale.must_respond_to :id
        sale.must_respond_to :amount
        sale.must_respond_to :purchase_time
        sale.must_respond_to :vendor_id
        sale.must_respond_to :product_id
      end
    end

  end

  describe "self.find" do
    it "raises an error if passed a non-integer" do
      proc {FarMar::Sale.find("pooky")}.must_raise ArgumentError
    end

    it "errors out if given an id that doesn't exist" do
      proc {FarMar::Sale.find(999999)}.must_raise ArgumentError
    end

    it "returns an instance of Sale" do
      test_sale = FarMar::Sale.find(6)
      test_sale.must_be_kind_of FarMar::Sale
    end

    it "given an id, finds the sale object that has that id" do
      test_sale = FarMar::Sale.find(2)
      test_sale.amount.must_equal 2262
    end

  end

  describe "vendor" do
    it "" do

    end
  end

  describe "product" do
    it "" do

    end
  end

  describe "self.between" do
    it "" do

    end
  end

end
