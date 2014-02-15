require 'rubygems'  
require 'sinatra'  
# require 'data_mapper'

# DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/recall.db")  
  
# class Note  
#   include DataMapper::Resource  
#   property :id, Serial 
#   property :item, Text, :required => true
#   property :location, Text, :required => true
#   property :tags, Text  
#   property :complete, Boolean, :required => true, :default => false  
#   property :created_at, DateTime  
#   property :updated_at, DateTime  
# end  

=begin
I think this is what we want but it's fucking up

class House_locations
  include DataMapper::Resource
  property :id, Serial
  property :location_name, Text, :required => true
  property :created_at, DateTime  
  property :updated_at, DateTime
end

class Room_containters
  include DataMapper::Resource
  property :id, Serial
  property :containter_name, Text, :required => true
  property :room_id, Serial
  property :created_at, DateTime  
  property :updated_at, DateTime
end

class Item
  include DataMapper::Resource
  property :id, Serial
  property :item_name, Text, :required => true
  property :container_id, Serial
  property :room_id, Serial
  property :created_at, DateTime  
  property :updated_at, DateTime
end

=end


# DataMapper.finalize.auto_upgrade!

get '/' do  
  @notes = Note.all :order => :id.desc  
  @title = 'All Notes'  
  erb :home  
end  

post '/' do  
  n = Note.new  
  n.item = params[:item]
  n.location = params[:location]
  n.tags = params[:tags]
  n.created_at = Time.now  
  n.updated_at = Time.now  
  n.save  
  redirect '/'  
end  

get '/:id' do  
  @note = Note.get params[:id]
  @title = "Edit note ##{params[:id]}"  
  erb :edit  
end  

put '/:id' do  
  n = Note.get params[:id]  
  n.item = params[:item]
  n.location = params[:location]
  n.tags = params[:tags]  
  n.updated_at = Time.now  
  n.save  
  redirect '/'  
end  

get '/:id/delete' do  
  @note = Note.get params[:id]  
  @title = "Confirm deletion of note ##{params[:id]}"  
  erb :delete  
end  

delete '/:id' do  
  n = Note.get params[:id]  
  n.destroy  
  redirect '/'  
end  

get '/:id/complete' do  
  n = Note.get params[:id]   
  n.updated_at = Time.now  
  n.save  
  redirect '/'  
end  

