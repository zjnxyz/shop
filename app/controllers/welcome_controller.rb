# coding: utf-8
class WelcomeController < ApplicationController
  skip_before_filter :require_login
  def index
  	@products1=Product.order("created_at desc").limit(4)
  	@brands=Brand.order("created_at desc")
  	@categories=Category.order("created_at")
  	@products2=Product.order("sales_volume desc").limit(4)
  end
end
