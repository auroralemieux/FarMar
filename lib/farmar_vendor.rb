require 'csv'

module FarMar

  class Vendor
    attr_reader :id, :name, :num_of_employees, :market_id

    def initialize(data_hash)
      raise ArgumentError.new "input must be hash" if data_hash.class != Hash

      @id = data_hash[:id]
      @name = data_hash[:name]
      @num_of_employees = data_hash[:num_of_employees]
      @market_id = data_hash[:market_id]
    end

    def market
      #returns the FarMar::Market instance that is associated with this vendor using the FarMar::Vendor market_id field
    end

    def products
      #returns a collection of FarMar::Product instances that are associated by the FarMar::Product vendor_id field.
    end

    def sales
      #returns a collection of FarMar::Sale instances that are associated by the vendor_id field.
    end

    def revenue
      #returns the the sum of all of the vendor's sales (in cents)
    end

    def self.all
      #returns a collection of instances, representing all of the objects described in the CSV
      my_file = CSV.open("support/vendors.csv")
      all_vendor_info = []
      my_file.each do |line|
        vendor_hash = {}
        vendor_hash[:id] = line[0]
        vendor_hash[:name] = line[1]
        vendor_hash[:num_of_employees] = line[2]
        vendor_hash[:market_id] = line[3]

        all_vendor_info << vendor_hash
      end
      all_vendors = []
      all_vendor_info.each do |vendor|
        new_vendor = FarMar::Vendor.new(vendor)
        all_vendors << new_vendor
      end

      return all_vendors
    end

    def self.find(find_this_id)
      raise ArgumentError.new "argument must be integer" unless find_this_id.class == Integer
      #returns an instance of the object where the value of the id field in the CSV matches the passed parameter
      all_vendors = FarMar::Vendor.all
      answer = nil
      all_vendors.each do |vendor|
        answer = vendor if vendor.id.to_i == find_this_id.to_i
      end
      raise ArgumentError.new "That vendor id doesn't exist!" if answer == nil
      return answer
    end

    def self.by_market(market_id)
      #returns all of the vendors with the given market_id
    end


  end

end
# puts FarMar::Vendor.all
# second_vendor = FarMar::Vendor.find(2)
# puts second_vendor.name

# ID - (Fixnum) uniquely identifies the vendor
# Name - (String) the name of the vendor (not guaranteed unique)
# No. of Employees - (Fixnum) How many employees the vendor has at the market
# Market_id - (Fixnum) a reference to which market the vendor attends
