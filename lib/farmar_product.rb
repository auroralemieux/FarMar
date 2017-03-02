require 'csv'

module FarMar

  class Product
    attr_reader :id, :name, :vendor_id

    def initialize(data_hash)
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
      #returns an instance of the object where the value of the id field in the CSV matches the passed parameter
      all_products = FarMar::Product.all
      answer = nil
      all_products.each do |product|
        answer = product if product.id.to_i == find_this_id.to_i
      end
      raise ArgumentError.new "That product id doesn't exist!" if answer == nil
      return answer
    end

    def self.between(beginning_time,end_time)
      #returns a collection of FarMar::Sale objects where the purchase time is between the two times given as arguments
    end

    def vendor
      #returns the FarMar::Vendor instance that is associated with this product using the FarMar::Product vendor_id field
    end

    def sales
      #returns a collection of FarMar::Sale instances that are associated using the FarMar::Sale product_id field.
    end

    def number_of_sales
      #returns the number of times this product has been sold.
    end

  end

end

# puts FarMar::Product.all
# second_product = FarMar::Product.find(2)
# puts second_product.name
# ID - (Fixnum) uniquely identifies the product
# Name - (String) the name of the product (not guaranteed unique)
# Vendor_id - (Fixnum) a reference to which vendor sells this product
