class Item < ActiveRecord::Base
  belongs_to :container

  validates :name, length: { minimum: 5 }

  def picture_search_url
    "http://images.google.com/?q=#{self.name}"
  end
end