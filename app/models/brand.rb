class Brand < ActiveRecord::Base
  #品牌分类
  mount_uploader :imgurl, AvatarUploader
  # 品牌名，商标
  attr_accessible :name, :imgurl,:imgurl_cache
  validates :name, :presence => true
  has_many :products,  :dependent => :destroy
  
end
