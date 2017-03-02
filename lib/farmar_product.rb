require 'csv'

module FarMar

  class Product
    attr_reader :id, :name, :vendor_id

    def initialize(data_hash)
      raise ArgumentError.new "input must be hash" if data_hash.class != Hash

      @id = data_hash[:id]
      @name = data_hash[:name]
      @vendor_id = data_hash[:vendor_id]
    end

    def self.all
      #returns a collection of instances, representing all of the objects described in the CSV
      my_file = CSV.open("support/products.csv")
      all_product_info = []
      my_file.each do |line|
        product_hash = {}
        product_hash[:id] = line[0]
        product_hash[:name] = line[1]
        product_hash[:vendor_id] = line[2]
        all_product_info << product_hash
      end
      all_products = []
      all_product_info.each do |product|
        new_product = FarMar::Product.new(product)
        all_products << new_product
      end

      return all_products
    end

    def self.find(find_this_id)
      raise ArgumentError.new "argument must be integer" unless find_this_id.class == Integer
      #returns an instance of the object where the value of the id field in the CSV matches the passed parameter
      all_products = FarMar::Product.all
      answer = nil
      all_products.each do |product|
        answer = product if product.id.to_i == find_this_id.to_i
      end
      raise ArgumentError.new "That product id doesn't exist!" if answer == nil
      return answer
    end

    def self.by_vendor(vendor_id_to_find)
      #returns all of the products with the given vendor_id
      all_products = FarMar::Product.all
      associated_vendors = []
      all_products.each do |product|
        associated_vendors << product if product.vendor_id == vendor_id_to_find
      end
      raise ArgumentError.new "no products found matching that vendor id" if associated_vendors.empty?
      return associated_vendors
    end

    def vendor
      #returns the FarMar::Vendor instance that is associated with this product using the FarMar::Product vendor_id field
      all_vendors = FarMar::Vendor.all
      answer = nil
      all_vendors.each do |vendor|
        answer = vendor if vendor.id == @vendor_id
      end
      raise ArgumentError.new "no vendor found" if answer == nil
      return answer

    end

    def sales
      #returns a collection of FarMar::Sale instances that are associated using the FarMar::Sale product_id field.
      all_sales = FarMar::Sale.all
      associated_sales = []
      all_vendors.each do |sale|
        associated_sales << sale if sale.product_id == @id
      end
      raise ArgumentError.new "no sales found" if associated_sales.empty?
      return associated_sales
    end

    def number_of_sales
      #returns the number of times this product has been sold.
      return sales.length
    end

  end

end


# ID - (Fixnum) uniquely identifies the product
# Name - (String) the name of the product (not guaranteed unique)
# Vendor_id - (Fixnum) a reference to which vendor sells this product
