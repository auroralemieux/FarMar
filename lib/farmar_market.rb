require 'csv'
# require_relative 'farmar_vendor'

module FarMar

  class Market
    attr_reader :id, :name, :address, :city, :county, :state, :zip

    def initialize(data_hash)
      @id = data_hash[:id]
      @name = data_hash[:name]
      @address = data_hash[:address]
      @city = data_hash[:city]
      @county = data_hash[:county]
      @state = data_hash[:state]
      @zip = data_hash[:zip]
    end

    def self.all
      #returns a collection of instances, representing all of the objects described in the CSV
      my_file = CSV.open("../support/markets.csv")
      all_market_info = []
      my_file.each do |line|
        market_hash = {}
        market_hash[:id] = line[0]
        market_hash[:name] = line[1]
        market_hash[:address] = line[2]
        market_hash[:city] = line[3]
        market_hash[:county] = line[4]
        market_hash[:state] = line[5]
        market_hash[:zip] = line[6]
        all_market_info << market_hash
      end
      all_markets = []
      all_market_info.each do |market|
        new_market = Market.new(market)
        all_markets << new_market
      end

      return all_markets
    end

    def self.find(find_this_id)
      #returns an instance of the object where the value of the id field in the CSV matches the passed parameter
      all_markets = FarMar::Market.all
      answer = nil
      all_markets.each do |market|
        answer = market if market.id.to_i == find_this_id.to_i
      end
      raise ArgumentError.new "That market id doesn't exist!" if answer == nil
      return answer
    end

    def vendors
      #returns a collection of FarMar::Vendor instances that are associated with the market by the market_id field.
      all_vendors = FarMar::Vendor.all
      associated_vendors = []
      all_vendors.each do |vendor|
        associated_vendors << vendor if vendor.market_id == @id
      end
      return associated_vendors

    end

  end

end
#
# puts FarMar::Market.all
# id_two = FarMar::Market.find(2)
# puts id_two.name



# ID - (Fixnum) a unique identifier for that market
# Name - (String) the name of the market (not guaranteed unique)
# Address - (String) street address of the market
# City - (String) city in which the market is located
# County - (String) county in which the market is located
# State - (String) state in which the market is located
# Zip - (String) zipcode in which the market is located
