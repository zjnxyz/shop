class Member < ActiveRecord::Base
  #会员类型表
  has_many :users
  #积分转换率，会员折扣，姓名
  attr_accessible :conversion_rate, :discount, :name
  validates :conversion_rate, :discount, :numericality => true
end
