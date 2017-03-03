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
      test_sale.amount.must_equal 22.62
    end

  end

  describe "vendor" do
    it "raises arg error if no vendor found" do
      proc {FarMar::Sale.new({id: 1, amount: 92.90, purchase_time: "2013-11-07 04:34:56 -0800", vendor_id: -1, product_id: 1}).vendor}.must_raise ArgumentError
    end
    it "returns a Vendor object" do
      FarMar::Sale.new({id: 1, amount: 92.90, purchase_time: "2013-11-07 04:34:56 -0800", vendor_id: 1, product_id: 1}).vendor.must_be_instance_of FarMar::Vendor
    end
    it "Vendor object id matches current Sales id" do
      sale = FarMar::Sale.new({id: 1, amount: 92.90, purchase_time: "2013-11-07 04:34:56 -0800", vendor_id: 1, product_id: 1})
      vendor = sale.vendor
      vendor.id.must_equal sale.vendor_id
    end
  end

  describe "product" do
    it "raises arg error if no product found" do
      proc {FarMar::Sale.new({id: 1, amount: 92.90, purchase_time: "2013-11-07 04:34:56 -0800", vendor_id: 1, product_id: -1}).product}.must_raise ArgumentError
    end
    it "returns a Product object" do
      FarMar::Sale.new({id: 1, amount: 92.90, purchase_time: "2013-11-07 04:34:56 -0800", vendor_id: 1, product_id: 1}).product.must_be_instance_of FarMar::Product
    end
    it "Vendor object id matches current Sales id" do
      sale = FarMar::Sale.new({id: 1, amount: 92.90, purchase_time: "2013-11-07 04:34:56 -0800", vendor_id: 1, product_id: 1})
      product = sale.product
      product.id.must_equal sale.product_id
    end
  end

  describe "self.between" do
    it "inputs must be readable as date_time objects -- error out if not" do
      proc {FarMar::Sale.between("yes", "no")}.must_raise ArgumentError
    end
    it "returns an array" do
      FarMar::Sale.between("2013-11-10 01:51:24 -0800", "2013-11-10 03:51:24 -0800").must_be_kind_of Array
    end

    it "all elements of array must be Sale objects" do
      all_sales_between = FarMar::Sale.between("2013-11-10 01:51:24 -0800", "2013-11-10 03:51:24 -0800")
      all_sales_between.each do |sale|
        sale.must_be_instance_of FarMar::Sale
      end
    end
  end

end
