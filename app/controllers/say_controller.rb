class SayController < ApplicationController
  skip_before_filter :require_login
  def find_p_by_brand
  	@brand=Brand.find(params[:id].to_i)
  	@products=Product.where("brand_id = ?",params[:id].to_i)
  	@products_group=@products.group_by{|p| p.category}
  	@order=Order.new
  end

  def find_p_by_category
  	@category=Category.find(params[:id].to_i)
  	@products=Product.where("category_id = ?",params[:id].to_i)
  	@products_group=@products.group_by{|p| p.brand}
  	@order=Order.new
  end
end
