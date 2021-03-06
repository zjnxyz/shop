class SayController < ApplicationController
  skip_before_filter :require_login
  def find_p_by_brand
  	@brand=Brand.find(params[:id].to_i)
  	@products=Product.where("brand_id = ? and status = ?",params[:id].to_i,true)
  	@products_group=@products.group_by{|p| p.category}
  	@order=Order.new
  end

  def find_p_by_category
  	@category=Category.find(params[:id].to_i)
  	@products=Product.where("category_id = ? and status = ?",params[:id].to_i,true)
  	@products_group=@products.group_by{|p| p.brand}
  	@order=Order.new
  end

  #得到某一个商品的详细信息，包括一些推荐的信息：同品牌的商品销售前四位和同一产品销售前四名
  def show_product

    @product1=Product.find(params[:id].to_i)

    @products=Product.where("brand_id = ? and id != ?",@product1.brand.id,@product1.id).order("sales_volume desc").limit(4)
    @products2=Product.where("category_id = ? and id != ?",@product1.category.id,@product1.id).order("sales_volume desc").limit(4)
    @order=Order.new
  end

  def search_product
    @type=params[:type].to_i #type=1表安品牌搜索，type=2：产品，type=3：商品
    @products=Array.new
    @param=params[:param]
    @order=Order.new
   
    if @type==1
      @brands=Brand.where("name LIKE ?","%"+@param+"%")
      @brands.each do |brand|
        @products+=Product.where("brand_id = ?",brand.id)
      end
    elsif @type==2
      @categories=Category.where("name LIKE ?","%"+@param+"%")
      @categories.each do |c|
         @products+=Product.where("category_id = ?",c.id)
      end

    elsif @type==3
      @products=Product.where("name LIKE ?","%"+@param+"%")
    end

  end 

end
