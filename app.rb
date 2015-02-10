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
	erb :'/welcome'
end

get '/foods' do 
	@foods = Food.all 
	erb :'foods/index'
end 

get '/foods/new' do
	@food = Food.new
	erb :'/foods/new'
 end

 get '/foods/:id' do 
 	@food = Food.find(params['id'])

 	erb :'/foods/show'
 end

post '/foods' do
	#pry.Start(binding)
	@name = params["food"]["name"]
	@cuisine = params["food"]["cuisine"]
	@price = params["food"]["price"]
	@allergens = params["food"]["allergens"]

	@food = Food.new({name: "#{@name}", cuisine: "#{@cuisine}", price: "#{@price}", allergens: "#{@allergens}"})
	if @food.save
		redirect to '/foods'
	else
		erb :'/foods/new'
	end
end

get '/foods/:id/edit' do 
 	@food= Food.find(params['id'])
 	erb :'foods/edit'
end

  patch '/foods/:id' do 
  	food = Food.find(params[:id])
 	food.update(params['food'])
 	redirect to "/foods/#{food.id}"
 end

  delete '/foods/:id' do 
 	food = Food.find(params[:id])
 	food.destroy
 	redirect to '/foods'
 end

 get '/parties' do 
 	@parties = Party.all

 	erb :'parties/index'
 end

  get '/parties/new' do  
 	@party = Party.all

 	erb :'parties/new'
 end

 get '/parties/:id' do 
 	#Pry.start(binding)
 	@party = Party.find(params[:id])
 	@foods = Food.all
 	erb :'parties/show'
 end

post '/parties/:id' do
	food_id = params["food_id"]
	party_id = params["id"]

end 

post '/parties' do  
	@guests = params["party"]["guest"]
	@table_number = params["party"]["table_number"]
	@paid = params["party"]["paid"]
	@party = Party.new({guests: "#{@guests}", table_number: "#{@table_number}", paid: "#{@paid}"})
	if @party.save
		redirect to '/parties'
	else
		erb :'/parties/new'
	end
end

get '/parties/:id/edit' do 
	@party = Party.find(params['id'])

 	erb :'parties/edit'
end

patch '/parties/:id' do 
	party = Party.find(params[:id])
 	party.update(params['party'])

 	redirect to "/parties/#{party.id}"
end

delete '/parties/:id' do 
	party = Party.find(params[:id])
 	party.destroy
 	redirect to '/parties'
end 

post '/orders' do
	@order = Order.new(params[:order])
	if @order.save
		redirect to "/parties/#{@order.party_id}"
	else
		erb :'parties/show'
	end
end

# patch '/orders/:id' do 
# 	@orders = Order.find(params['id')

#  	erb :'orders/edit'
	
# end

delete '/orders/:id' do 
	order = Order.find(params[:id])
 	order.destroy
 	redirect to '/orders'
end

# get '/parties/:id/receipt' do 
# end

# patch '/parties/:id/checkout' do 


# get '/download/:filename' do |filename|
#  send_file "./files/#{filename}", :filename => filename, :type => 'Application/octet-stream'
# end


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
