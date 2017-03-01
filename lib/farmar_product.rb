module FarMar

  class Product
    attr_reader
    def initialize
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

    def self.between(beginning_time,end_time)
      #returns a collection of FarMar::Sale objects where the purchase time is between the two times given as arguments
    end

  end

end

# ID - (Fixnum) uniquely identifies the product
# Name - (String) the name of the product (not guaranteed unique)
# Vendor_id - (Fixnum) a reference to which vendor sells this product
