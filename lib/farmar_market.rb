module FarMar

  class Market
    attr_reader
    
    def initialize
    end

    def self.all
      #returns a collection of instances, representing all of the objects described in the CSV
    end

    def self.find(id)
      #returns an instance of the object where the value of the id field in the CSV matches the passed parameter
    end

    def vendors
      #returns a collection of FarMar::Vendor instances that are associated with the market by the market_id field.
    end

  end

end

# ID - (Fixnum) a unique identifier for that market
# Name - (String) the name of the market (not guaranteed unique)
# Address - (String) street address of the market
# City - (String) city in which the market is located
# County - (String) county in which the market is located
# State - (String) state in which the market is located
# Zip - (String) zipcode in which the market is located
