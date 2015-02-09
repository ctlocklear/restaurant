require 'bundler'
require 'active_record'
Bundler.require 
require 'pry'

if `whoami`.chomp == 'clocklear'
	ActiveRecord::Base.establish_connection({adapter: 'postgresql', database: 'restaurants', host: 'localhost', port: 5432})
else
	ActiveRecord::Base.establish_connection({adapter: 'postgresql', database: 'restaurants'})
end

require_relative 'models/food'
require_relative 'models/order'
require_relative 'models/party'


get '/' do
	'Welcome to my restaurant!'
end

get '/foods' do 
	@foods = Food.all 
	erb :'foods/index'
end 


 # get '/foods/:id' do 
 # food_id = params['id']
 # @foods = Food.find(food_id)

 #  erb :'/foods/show'
 #  end

get '/foods/new' do 
	@foods = Food.all
	erb :'/foods/new'
 end

post '/foods' do
	#pry.Start(binding)
	@name = params["food"]["name"]
	@cuisine = params["food"]["cuisine"]
	@price = params["food"]["price"]
	@allergens = params["food"]["allergens"]

	@foods = Food.create({name: "#{@name}", cuisine: "#{@cuisine}", price: "#{@price}", allergens: "#{@allergens}"})
  redirect to '/foods'
end

#  get 'foods/:id/edit' do 
#  	@foods= Food.find(params['id'])
#  	erb :'foods/edit'
# end

#  patch '/foods/:id' do 
#  	food = Food.find(params[:id])
#  	food.update(params[:id])

#  	redirect to "/foods/#{food.id}"
# end

#  	redirect to '/foods/#{food.id}'
# end

#  delete '/foods/:id' do 
#  	food = Food.find(params[:id])
#  	food.destory

#  	redirect to '/foods'
#  end

#  get '/parties' do 
#  	@parties = Party.all

#  	erb :'parties/index'
#  end

#  get '/parties/:id' do 
#  	@parties = Party.find(params[:id])

#  	erb :'parties/show'
#  end

#  get '/parties/new' do  
#  	@parties = Party.all

#  	erb :'parties/new'
#  end

# post '/parties' do  
# 	new_parties = params['new_parties']
# 	@parties = Party.create({name: new_parties})

#   redirect to '/parties'
# end

# get '/parties/:id/edit' do 
# 	@parties = Party.find(params['id')

#  	erb :'parties/edit'
# end

# patch '/parties/:id' do 
# 	party = Party.find(params[:id])
#  	party.update(params[:table_number])

#  	redirect to '/parties/#{party.id}'
# end

# delete '/parties/:id' do 
# 	party = Party.find(params[:id])
#  	party.destory

#  	redirect to '/parties'
# end

# post '/orders' do 
# 	new_orders = params['new_orders']
# 	@orders = Order.create({name: new_orders})

# 	erb :'order/new'
# end

# patch '/orders/:id' do 
# 	@orders = Order.find(params['id')

#  	erb :'orders/edit'
	
# end

# delete '/orders/:id' do 
# 	order = Order.find(params[:id])
#  	order.destory

#  	redirect to '/orders'
# end

# get '/parties/:id/receipt' do 
# end

# patch '/parties/:id/checkout' do 

# GET | / | Displays links to navigate the application (including links to each current parties)
# GET | /foods | Display a list of food items available
# GET | /foods/:id | Display a single food item and a list of all the parties that included it
# GET | /foods/new | Display a form for a new food item
# POST | /foods | Creates a new food item
# GET | /foods/:id/edit | Display a form to edit a food item
# PATCH | /foods/:id | Updates a food item
# DELETE | /foods/:id | Deletes a food item
# GET | /parties | Display a list of all parties
# GET | /parties/:id | Display a single party, options for adding a food item to the party and closing the party.
# GET | /parties/new | Display a form for a new party
# POST | /parties | Creates a new party
# GET | /parties/:id/edit | Display a form for to edit a party's details
# PATCH | /parties/:id | Updates a party's details
# DELETE | /parties/:id | Delete a party
# POST | /orders | Creates a new order
# PATCH | /orders/:id | Change item to no-charge
# DELETE | /orders/:id | Removes an order
# GET | /parties/:id/receipt | Saves the party's receipt data to a file. Displays the content of the receipt. Offer the file for download.
# PATCH | /parties/:id/checkout | Marks the party as paid
