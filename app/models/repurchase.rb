class Repurchase < ActiveRecord::Base
  #退货单
  belongs_to :sell
  belongs_to :staff
  belongs_to :user
                 #退货金额 ，数量，备注，购买金额，是否处理
  attr_accessible :actual_sum, :amount, :remark, :sum, :status, :sell, :staff, :user
end
