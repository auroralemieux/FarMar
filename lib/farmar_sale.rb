module FarMar

  class Sale
    attr_reader
    
    def initialize
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
    end

    def self.find(id)
      #returns an instance of the object where the value of the id field in the CSV matches the passed parameter
    end

  end

end
#
# ID - (Fixnum) uniquely identifies the sale
# Amount - (Fixnum) the amount of the transaction, in cents (i.e., 150 would be $1.50)
# Purchase_time - (Datetime) when the sale was completed
# Vendor_id - (Fixnum) a reference to which vendor completed the sale
# Product_id - (Fixnum) a reference to which product was sold
