json.type "FeatureCollection"
json.features do
  json.array! @geojson do |geo|
    json.type "feature"
    json.geometry do
      json.type "Point"
      json.coordinates do
        json.lat geo["geometry"]["coordinates"][0]
        json.lng geo["geometry"]["coordinates"][1]
      end
    end
    json.properties do
      json.id geo["properties"]["id"]
      json.price geo["properties"]["price"]
      json.street geo["properties"]["street"]
      json.bedrooms geo["properties"]["bedrooms"]
      json.bathrooms geo["properties"]["bathrooms"]
      json.sq_ft geo["properties"]["sq_ft"]
    end
  end
end
