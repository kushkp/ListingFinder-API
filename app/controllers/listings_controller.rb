require 'set'
require 'rgeo/geo_json'
# require 'geojson'
# require 'geo_ruby'

class ListingsController < ApplicationController
  def index
    search_by = []
    params.keys.each do |param|
      search_by << param if SEARCH_PARAMS.include?(param)
    end

    listings = filter_by_data(search_by, params)


    @geojson = convert_to_geojson(listings)
    # hash = RGeo::GeoJSON.encode(geojson_listings)
    render text: @geojson
  end

private

  def convert_to_geojson(listings)
    feature_collection = {}
    feature_collection_features = []
    listings.each do |listing|
      properties = {
        id: listing["id"],
        price: listing["price"],
        street: listing["street"],
        bedrooms: listing["bedrooms"],
        bathrooms: listing["bathrooms"],
        sq_ft: listing["sq_ft"]
      }
      feature = {
        type: "feature",
        geometry: { type: "Point", coordinates: [listing["lat"],listing["lng"]] },
        properties: properties
      }
      feature_collection_features << feature
    end

    feature_collection[:type] = "FeatureCollection"
    feature_collection[:features] = feature_collection_features

    feature_collection
  end
  #
  # def convert_to_geojson(listings)
  #   feature_collection = []
  #   listings.each do |listing|
  #     properties = {
  #       "id" => listing["id"],
  #       "price" => listing["price"],
  #       "street" => listing["street"],
  #       "bedrooms" => listing["bedrooms"],
  #       "bathrooms" => listing["bathrooms"],
  #       "sq_ft" => listing["sq_ft"]
  #     }
  #
  #     factory = RGeo::GeoJSON::EntityFactory.instance
  #     factory.feature("Point", properties)
  #
  #     # str = "{'type':'Feature','geometry':{'type':'Point','coordinates':[#{listing.lat},#{listing.lng}]},'properties':{ 'id': #{listing.id}, 'price': #{listing.price}, 'street': #{listing.street}, 'bedrooms': #{listing.bedrooms}, 'bathrooms': #{listing.bathrooms}, 'sq_ft': #{listing.sq_ft}}}"
  #
  #     debugger
  #     feature = RGeo::GeoJSON.decode(str, :json_parser => :json)
  #     feature_collection << feature
  #   end
  #
  #   feature_collection
  # end

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
