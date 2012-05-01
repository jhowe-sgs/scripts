#!/opt/local/bin/ruby

require 'geocoder'

# Inspired by http://batchgeo.com/

# csv.each do
r=Geocoder.search("Street Adress, City, State, ZIP, Country")
zipcode=r[0].address_components[7]["short_name"]
lat-lng=r[0].geometry["location"]

# rails

# class Location < ActiveRecord::Base
#   geocoded_by: address, :latitude => :lat, :longitude => :lng
# end

# def address
#   [street1, city, state, country].compact.join(', ')
# end
