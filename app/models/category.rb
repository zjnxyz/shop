class Category < ActiveRecord::Base
  #产品
  # 产品名，产品图片
  attr_accessible :name,:imgurl
  validates :name, :presence => true
  has_many :products,  :dependent => :destroy
end
