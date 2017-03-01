module FarMar

  class Vendor
    attr_reader
    def initialize
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

    def self.by_market(market_id)
      #returns all of the vendors with the given market_id
    end


  end

end

# ID - (Fixnum) uniquely identifies the vendor
# Name - (String) the name of the vendor (not guaranteed unique)
# No. of Employees - (Fixnum) How many employees the vendor has at the market
# Market_id - (Fixnum) a reference to which market the vendor attends
