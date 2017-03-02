require 'csv'

module FarMar

  class Sale
    attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id

    def initialize(data_hash)
      @id = data_hash[:id]
      @amount = data_hash[:amount]
      @purchase_time = data_hash[:purchase_time]
      @vendor_id = data_hash[:vendor_id]
      @product_id = data_hash[:product_id]
    end

    def vendor
      #returns the FarMar::Vendor instance that is associated with this sale using the FarMar::Sale vendor_id field
    end

    def product
      #returns the FarMar::Product instance that is associated with this sale using the FarMar::Sale product_id field
    end

    def self.between(beginning_time, end_time)
      #returns a collection of FarMar::Sale objects where the purchase time is between the two times given as arguments
    end

    def self.all
      #returns a collection of instances, representing all of the objects described in the CSV
      my_file = CSV.open("../support/sales.csv")
      all_sale_info = []
      my_file.each do |line|
        sale_hash = {}
        sale_hash[:id] = line[0]
        sale_hash[:amount] = line[1]
        sale_hash[:purchase_time] = line[2]
        sale_hash[:vendor_id] = line[3]
        sale_hash[:product_id] = line[4]

        all_sale_info << sale_hash
      end
      all_sales = []
      all_sale_info.each do |sale|
        new_sale = FarMar::Sale.new(sale)
        all_sales << new_sale
      end

      return all_sales
    end

    def self.find(find_this_id)
      #returns an instance of the object where the value of the id field in the CSV matches the passed parameter
      all_sales = FarMar::Sale.all
      answer = nil
      all_sales.each do |sale|
        answer = sale if sale.id.to_i == find_this_id.to_i
      end
      raise ArgumentError.new "That sale id doesn't exist!" if answer == nil
      return answer
    end

  end

end
#

# puts FarMar::Sale.all
# second_sale = FarMar::Sale.find(2)
# puts second_sale.amount
# ID - (Fixnum) uniquely identifies the sale
# Amount - (Fixnum) the amount of the transaction, in cents (i.e., 150 would be $1.50)
# Purchase_time - (Datetime) when the sale was completed
# Vendor_id - (Fixnum) a reference to which vendor completed the sale
# Product_id - (Fixnum) a reference to which product was sold
