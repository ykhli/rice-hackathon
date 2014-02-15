class Room < ActiveRecord::Base
  has_many :containers, :dependent => :destroy
  has_many :items, :through => :containers
end
