class Image < ActiveRecord::Base
  belongs_to :product
  attr_accessible :img_url
end
