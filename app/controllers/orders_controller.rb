# coding: utf-8
class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index

    if !session[:user_id].blank?
      @orders=Order.where("user_id = ? ",session[:user_id]).order("created_at desc")
    elsif !session[:staff_id].blank?
      @search=Order.search(params[:search])
      @orders= @search.order("created_at desc").page(params[:page]).per(5)
    end
   
    respond_to do |format|
      format.html # index.html.erb
      format.js{ render :layout => false }
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  #创建预订单，用户最多只能预订两件商品。
  def create
    @p_id=params[:p_id].to_i
    @product=Product.find(@p_id)
    @order = Order.new(params[:order])
    @order.product=@product
    @order.end_time=Time.now+7.days


    respond_to do |format|
      if session[:user_id].blank?
        flash[:notice]="您还没有登录啦，请先登录再预订商品！"
        format.js{ render :layout => false }
      else
        @order.user=User.find(session[:user_id])
        @orders=Order.where("user_id=?",session[:user_id])
        @count=@order.amount.to_i
        if !@orders.blank?
           @orders.each do |o|
            @count+=o.amount.to_i
           end
        end

        if @count < 3
          if @product.stock_quantity.to_i < @order.amount.to_i
            flash[:notice]="对不起，库存不足，请您少预订一些！"
            format.js{ render :layout => false }
          else

            if @order.save
              #@product.update_attributes(:stock_quantity=>@product.stock_quantity.to_i-@order.amount.to_i) 
              flash[:notice] = "预订成功，请在一个星期内到实体店付钱购买！"
              format.js{ render :layout => false }
              format.json { render json: @order, status: :created, location: @order }
            else
              format.html { render action: "new" } 
              format.json { render json: @order.errors, status: :unprocessable_entity }
            end

          end

          
        else
           flash[:notice]="对不起，您已经有预订了两件商品，不能再预订了，您可以选择删除一件商品，再预订！"
           format.js{ render :layout => false }
        end
       


        
      end
      
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
end
