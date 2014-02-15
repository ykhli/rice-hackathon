require 'sinatra'
require 'sinatra/activerecord'

ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => './tmp/development.sqlite3'
)

Dir["./models/*.rb"].each { |file| require file }

# require './recall.rb'

get '/' do  
  @rooms = Room.order('name ASC').all
  @justrooms = Room
  @items = Item.order('created_at').limit(4).all
  @title = 'All rooms and recent items'
  erb :home  
end  

post '/' do  
  nroom = Room.find_or_create_by(name: params[:nroom_name])

  container_name = params[:ncontainer_name]
  ncontainer    = nroom.containers.where(name: container_name).first
  ncontainer  ||= nroom.containers.create(name: container_name)

  nitem = ncontainer.items.create(name: params[:nitem_name])
  redirect '/'  
end  

### Room ###

# edit room
get '/room/:id' do  
  @rooms = Room.find params[:id]
  @title = "Edit Room Name ##{params[:id]}"  
  erb :roomedit  
end  

put '/room/:id' do  
  n = Room.find params[:id]  
  n.name = params[:nroom_name]
  n.updated_at = Time.now  
  n.save  
  redirect '/'  
end  

# delete room
get '/room/:id/delete' do  
  @rooms = Room.find params[:id]  
  @title = "Confirm Deletion of Room ##{params[:id]}"  
  erb :roomdelete  
end  

delete '/room/:id' do  
  n = Room.find params[:id]  
  n.destroy  
  redirect '/'  
end  

# containers in a room
get '/containers/room_:id' do
  @containers = Room.find params[:id]
  @title = "Containers in Room ##{params[:room_id]}"
  erb :containerviews
end
### End Room ###


### Containers ###

# edit container
get '/container/:id' do  
  @containers = Container.find params[:id]
  @title = "Edit Container Name ##{params[:id]}"  
  erb :containeredit  
end  

put '/container/:id' do  
  n = Container.find params[:id]  
  n.name = params[:ncontainer_name]
  n.updated_at = Time.now  
  n.save  
  redirect '/'  
end  

# delete container
get '/container/:id/delete' do  
  @containers = Container.find params[:id]  
  @title = "Confirm Deletion of Container ##{params[:id]}"  
  erb :containerdelete  
end  

delete '/container/:id' do  
  n = Container.find params[:id]  
  n.destroy  
  redirect '/'  
end  

# items in a container
get '/items/container_:id' do
  @items = Container.find params[:id]
  @title = "Items in Container ##{params[:container_id]}"
  erb :itemviews
end
### End Container ###


### Items ###

# edit item
get '/item/:id' do  
  @items = Item.find params[:id]
  @title = "Edit Item Name ##{params[:id]}"  
  erb :itemedit  
end  

put '/item/:id' do  
  n = Item.find params[:id]  
  n.name = params[:nitem_name]
  n.updated_at = Time.now  
  n.save  
  redirect '/'  
end  

# delete item
get '/item/:id/delete' do  
  @items = Item.find params[:id]  
  @title = "Confirm Deletion of Item ##{params[:id]}"  
  erb :itemdelete  
end  

delete '/item/:id' do  
  n = Item.find params[:id]  
  n.destroy  
  redirect '/'  
end  

# # items in a container
# get '/items/container_:id/' do
#   @items = Item.find params[:container_id]
#   @title = "Items in Container ##{params[:room_id]}"
# end