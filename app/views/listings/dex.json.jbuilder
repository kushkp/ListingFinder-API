json.array!(@listings) do |listing|
  # json.partial! '/listing', listing: listing
  json.type "FeatureCollection"
  json.geometry {"type": "Point", lat: listing.lat}
end
