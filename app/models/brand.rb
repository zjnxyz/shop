class Brand < ActiveRecord::Base
  #品牌分类
  # 品牌名，商标
  attr_accessible :name, :imgurl
  validates :name, :presence => true
  has_many :products,  :dependent => :destroy
  
end
