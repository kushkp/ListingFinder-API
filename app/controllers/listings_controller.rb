require 'set'

class ListingsController < ApplicationController
  def index
    search_by = []
    params.keys.each do |param|
      search_by << param if SEARCH_PARAMS.include?(param)
    end

    @listings = filter_by_data(search_by, params)

    render json: @listings
  end

private

  def filter_by_data(options, params)
    listings = Listing.all

    options.each do |option|
      case option
      when "min_price"
        listings = listings.where("price >= ?", params["min_price"])
      when"max_price"
        listings = listings.where("price <= ?", params["max_price"])
      when "min_bed"
        listings = listings.where("bedrooms >= ?", params["min_bed"])
      when "max_bed"
        listings = listings.where("bedrooms <= ?", params["max_bed"])
      when "min_bath"
        listings = listings.where("bathrooms >= ?", params["min_bath"])
      when "max_bath"
        listings = listings.where("bathrooms <= ?", params["max_bath"])
      end
    end

    listings
  end


  SEARCH_PARAMS = Set.new [
    "min_price",
    "max_price",
    "min_bed",
    "max_bed",
    "min_bath",
    "max_bath",
  ]
end
