#ListingFinder-API

Live: [ListingFinder-API][live]
[live]: http://listingfinder-api.herokuapp.com/listings

##Description

  An API written in Ruby that filters listings by price, No. of bathrooms, and No. of bedrooms.
  Takes query string input and returns listings in GeoJSON format for easy integration with maps.

##Usage

  User may search for listings by appending a query string with the following parameters:
  - min_price: The minimum listing price in dollars.
  - max_price: The maximum listing price in dollars.
  - min_bed: The minimum number of bedrooms.
  - max_bed: The maximum number of bedrooms.
  - min_bath: The minimum number of bathrooms.
  - max_bath: The maximum number of bathrooms.
  - min_sqft: The minimum amount of sq footage.
  - max_sqft: The maximum amount of sq footage.

  Append query string to URL:
  GET /listings?min_price=100000&max_price=200000&min_bed=2&max_bed=2&min_bath=2&max_bath=2


##Future Plans
  - Refactor ActiveRecord query
  - Paginate listing results to reduce load time
  - Ability to search by location and given radius
  - Implement create and edit routes to add and modify listings
