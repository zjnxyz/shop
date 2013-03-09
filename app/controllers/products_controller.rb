# coding: utf-8
class ProductsController < ApplicationController
  autocomplete :product, :number,:full => true

  # GET /products
  # GET /products.json
  def index
    @search = Product.search(params[:search])
    @products = @search.order("number desc").page(params[:page]).per(5)

    respond_to do |format|
      format.html # index.html.erb
      format.js{ render :layout => false }
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new
    @units = Unit.all
    @brands = Brand.all
    @categories = Category.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @units = Unit.all
    @brands = Brand.all
    @categories = Category.all
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])
    @brand = Brand.find(params[:brand_id])
    @product.brand= @brand
    @unit = Unit.find(params[:unit_id])
    @product.unit= @unit
    @category = Category.find(params[:category_id])
    @product.category= @category
    @product.stock_quantity=0
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: '商品创建成功.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: '商品更新成功.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # get /products/1
  # get /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def pre_add_product

  end

  def add_product
    @p_number=params[:number]
    @p_price = params[:p_price]
    @p_num= params[:p_num]
    begin
      @product = Product.find_by_number(@p_number)
    rescue  ActiveRecord::RecordNotFound
      # format.html { render action: "index",notice: '数据库中没有该商品，请检查商品编码是否输入错误.' }
      # format.json { render json: @product.errors, status: :unprocessable_entity }
    end
    respond_to do |format|
     if !@product.blank?
       #@product1=@product
       @p_num1= @p_num.to_i + @product.stock_quantity.to_i
       #@product1.stock_quantity= @p_num.to_i
       Product.update(@product.id,:purchase_price =>@p_price,:stock_quantity =>@p_num1)
       format.html { redirect_to @product, notice: '增加库存成功.' }
       format.json { head :no_content }
     else
       format.html { render action: "pre_add_product",notice: '数据库中没有该商品，请检查商品编码是否输入错误.' }
       format.json { render json: @product.errors, status: :unprocessable_entity }
     end
    end
  end
  #查询库存
  def pre_query
    @search = Product.search(params[:search])
    @products = @search.where("status=? and stock_quantity>0 ",true).order("created_at desc").page(params[:page])
    respond_to do |format|
      format.html # query.html.erb
      format.js{ render :layout => false }
    end
  end 
  
  #准备盘点库存
  def pre_check 
    @search = Product.search(params[:search])
    @products = @search.where("status=?",true).order("number desc").page(params[:page])
    respond_to do |format|
      format.html # query.html.erb
      format.js{ render :layout => false }
    end
  end

  def check
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html # query.html.erb
      format.js{ render :layout => false }
    end
  end

  def after_check
     @product = Product.find(params[:p_id].to_i)
     @sum=params[:sum].to_i
    respond_to do |format|
      if @product.update_attributes(:stock_quantity=>@sum)
        @search = Product.search(params[:search])
        @products = @search.where("status=?",true).page(params[:page])
        format.html { render action: "pre_check", notice: '库存盘点完成！' }
        format.js{ render :layout => false }
        format.json { head :no_content }
      else
        format.html { render action: "pre_check" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def low_stack
    @search = Product.search(params[:search])
    @products = @search.where("status=? and stock_quantity<stock_lower_limit",true).order("number desc").page(params[:page])
    respond_to do |format|
        format.html # query.html.erb
        format.js{ render :layout => false }
    end
  end

  #进货准备
  def purchase
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html # purchase.html.erb
      format.js{ render :layout => false }
    end
  end

  #进货
  def after_purchase
    @p_price = params[:p_price]
    @p_num= params[:p_num].to_i
    respond_to do |format|
      @product=Product.find(params[:p_id].to_i)
      if !@product.blank?
        @sum=@p_num+@product.stock_quantity.to_i
        if @product.update_attributes(:purchase_price=>@p_price,:stock_quantity=>@sum)
           @search = Product.search(params[:search])
           @products = @search.where("status=? and stock_quantity<stock_lower_limit",true).page(params[:page])
           format.html # purchase.html.erb
           format.js{ render :layout => false }
        end
      end
     format.html { render action: "purchase" }
     format.json { render json: @product.errors, status: :unprocessable_entity }
    end 
  end

  def pre_add_sell

    @product=Product.find(params[:id])

  end

end
