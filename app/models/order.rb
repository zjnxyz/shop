class Order < ActiveRecord::Base
  #用户订单--用于预订时候使用的
  belongs_to :product
  belongs_to :user
  #实际金额，数量，备注，金额, 到期时间
  attr_accessible :actual_sum, :amount, :remark, :sum, :end_time
end
