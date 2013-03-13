class Category < ActiveRecord::Base
  #产品
  mount_uploader :imgurl, AvatarUploader
  # 产品名，产品图片
  attr_accessible :name,:imgurl,:imgurl_cache
  validates :name, :presence => true
  has_many :products,  :dependent => :destroy
end
