require 'pg'
require 'active_record'
require 'pry'

Dir["../models/*.rb"].each do |file|
  require_relative file
end

ActiveRecord::Base.establish_connection(
adapter: "postgresql",
database: "restaurants",
)
#Pry.start(binding)

ActiveRecord::Base.connection.execute(<<-SQL)
  DROP TABLE IF EXISTS foods;
  CREATE TABLE foods
  (
    id serial NOT NULL,
    name text,
    cuisine text,
    price integer,
    allergens text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT foods_pkey PRIMARY KEY (id)
  );
SQL

ActiveRecord::Base.connection.execute(<<-SQL)
  DROP TABLE IF EXISTS orders;
  CREATE TABLE orders
  (
    id serial NOT NULL,
    food_id integer,
    party_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT orders_pkey PRIMARY KEY (id)
  )
SQL

ActiveRecord::Base.connection.execute(<<-SQL)
  DROP TABLE IF EXISTS parties;
  CREATE TABLE parties
  (
    id serial NOT NULL,
    table_number integer,
    guests integer,
    paid boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT parties_pkey PRIMARY KEY (id)
  )
SQL

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


