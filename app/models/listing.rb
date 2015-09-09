class Listing < ActiveRecord::Base
  attr_reader :street, :status,
              :price, :bedrooms,
              :bathrooms, :sq_ft,
              :lat, :lng

end
