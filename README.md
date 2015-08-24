# ArcGIS Online Ruby Library

This library is a simple wrapper around the ArcGIS Online sharing API for Users, Groups, Items, and Search. 

The library currently just exposes the API endpoints and accepts unverified hashes of input parameters as specified in the [ArcGIS API](http://www.arcgis.com/apidocs/rest/). As it evolves more endpoints will be added as well as more Ruby-like objects for the various API capabilities.

If you want to query the FeatureService and MapService endpoitns, then check out the [GeoServices-Ruby](https://github.com/esri/geoservices-ruby) library. 

## Install

Just install using Rubygems:

`gem install geoservices`

## Instructions

```ruby
# Create a client
@online = Arcgis::Online.new(:host => "http://www.arcgis.com/sharing/rest/")
# Do an unauthenticated search
results = @online.search(:q => "weather", :itemtype => "Web Map")

# For features with permissions, first log in
@online.login(:username => @username, :password => @password)

# Create an item
response = @online.item_add( :title => "Weather Station Temperatures",
                  :type => "CSV",
                  :file => File.open("my_data.csv"),
                  :tags  => %w{temperature stations}.join(","))

@id = response["id"]
puts "This item has #{response['numComments']} comments."

# Publish as a feature service
analysis = @online.item_analyze(:id => @id, :type => "CSV")
publish = @online.item_publish(:id => @id,
                               :filetype => "Feature Service",
                               :publishParameters => analysis["publishParameters"].to_json)

puts "Feature Service URL: " + publish["services"].first["serviceurl"]

# Clean up
@online.item_delete(:items => [@id, publish["services"].first["serviceItemId"]])
```

### Testing

arcgis-ruby uses RSpec for tests. First copy @config.yml.example@ to @config.yml@ and modify the username and password. Then from the command line run:

    $ rspec

If your arcgis online user is a public user, i.e. not allowed to create groups or publish items, then run:

    $ rspec --tag ~@privileged 

This will skip tests that require publisher access.


## Requirements

* Ruby

## Resources

* [ArcGIS Portal API](http://www.arcgis.com/apidocs/rest/)

## Licensing
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

A copy of the license is available in the repository's [license.txt](./license.txt) file.

[](Esri Tags: ArcGIS Ruby API AGOL Public)
[](Esri Language: Ruby)
