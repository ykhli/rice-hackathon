class Container < ActiveRecord::Base
  belongs_to :room
  has_many :items, :dependent => :destroy

  # validates :name, uniqueness: true
end