#ListingFinder-API

Live: [ListingFinder-API][live]
[live]: http://listingfinder-api.herokuapp.com/listings

##Description

  An API written in Ruby that filters listings by price, No. of bathrooms, and No. of bedrooms.
  Takes query string input and returns listings in GeoJSON format for easy integration with maps.

##Usage

  User may search for listings by appending a query string with the following parameters:
  - min_price
  - max_price
  - min_bed
  - max_bed
  - min_bath
  - max_bath

##Future Plans
  - Refactor ActiveRecord query
  - Paginate listing results to reduce load time
  - Ability to search by location and given radius
  - Implement create and edit routes to add and modify listings
