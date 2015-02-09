require 'pg'
require 'active_record'
require 'pry'

Dir["../models/*.rb"].each do |file|
  require_relative file
end

ActiveRecord::Base.establish_connection(
adapter: "postgresql",
database: "restaurants",
host: "localhost",
port: 5432
)
#Pry.start(binding)



[
  {
    name: "Pizza",
    cuisine: "Italian",
    price: 5,
    allergens: "none"
  },
  {
    name: "Cheeseburger",
    cuisine: "American",
    price: 10,
    allergens: "none"
  },
  {
    name: "Macaroni and Cheese with Snails",
    cuisine: "nouveau riche",
    price: 55,
    allergens: "none"
  },
  {
    name: "Bolonga",
    cuisine: "Canadian",
    price: 2,
    allergens: "none"
  }]
 .each do |food|
  Food.create( food )
end
 
[
  {table_number: 1,
   guests: 5,
   paid: true 

  },
  {table_number: 2,
   guests: 7,
   paid: false


  }]
  .each do |party|
  Party.create( party )
end


