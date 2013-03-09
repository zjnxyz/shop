class Unit < ActiveRecord::Base
  #单位表
  attr_accessible :name
  validates :name, :presence => true
  has_many :products,  :dependent => :destroy
end
