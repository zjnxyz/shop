# coding: utf-8
class Sell < ActiveRecord::Base
  #销售单
  belongs_to :user
  belongs_to :staff
  belongs_to :product
  has_many :repurchases
                  #实际金额， 数量，备注，金额 , 实际折扣，使用的积分,是否退货：true-表示退货
  attr_accessible :actual_sum, :amount, :remark, :sum, :real_discount, :use_integral, :status

  #计算商品实际价格
  def count_money(sell,user)
  	@money=sell.amount*(sell.sum*sell.real_discount)-sell.use_integral*user.member.conversion_rate
  	@money
  end

  def check_sell(actual_sum,amount)

  	 self.update_attributes(:actual_sum=>actual_sum)
     @product=self.product
     @product.update_attributes(:stock_quantity=>@product.stock_quantity-amount,:sales_volume=>@product.sales_volume.to_i+amount)
     @user=self.user
     @m=actual_sum*0.1;
     @user.update_attributes(:integral=>@user.integral.to_i-self.use_integral.to_i+@m.to_i)

     true
  end

end
