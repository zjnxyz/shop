class Photo < ActiveRecord::Base
  mount_uploader :image, PhotoUploader
  attr_accessible :image
end
