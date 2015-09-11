require 'set'
require 'rgeo/geo_json'

class ListingsController < ApplicationController
  def index
    search_by = []
    params.keys.each do |param|
      search_by << param if SEARCH_PARAMS.include?(param)
    end

    listings = filter_by_data(search_by, params)
    @geojson = convert_to_geojson(listings)

    render json: @geojson
  end

private
  SEARCH_PARAMS = Set.new [
    "min_price",
    "max_price",
    "min_bed",
    "max_bed",
    "min_bath",
    "max_bath",
  ]

  def convert_to_geojson(listings)
    feature_collection = {}
    feature_collection_features = []
    listings.each do |listing|
      feature_collection_features << create_feature(listing)
    end

    feature_collection["type"] = "FeatureCollection"
    feature_collection["features"] = feature_collection_features

    feature_collection
  end

  def create_feature(listing)
    properties = {
      "id" => listing["id"],
      "price"  => listing["price"],
      "street" => listing["street"],
      "bedrooms" => listing["bedrooms"],
      "bathrooms" => listing["bathrooms"],
      "sq_ft" => listing["sq_ft"]
    }
    feature = {
      "type" => "feature",
      "geometry" => { "type" => "Point", "coordinates" => [listing["lat"],listing["lng"]] },
      "properties" => properties
    }
  end

  def filter_by_data(options, params)
    where_query = ""
    query_values = []

    options.each do |option|
      if where_query == ""
        where_query += single_where_cond(option)
      else
        where_query += " AND " + single_where_cond(option)
      end
      query_values << "#{params[option]}"
    end

    Listing.where(where_query, *query_values)
  end

  def single_where_cond(option)
    case option
    when "min_price"
      return "price >= ?"
    when "max_price"
      return "price <= ?"
    when "min_bed"
      return "bedrooms >= ?"
    when "max_bed"
      return "bedrooms <= ?"
    when "min_bath"
      return "bathrooms >= ?"
    when "max_bath"
      return "bathrooms <= ?"
    end
  end
end
