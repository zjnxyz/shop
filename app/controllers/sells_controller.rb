# coding: utf-8
class SellsController < ApplicationController
  # GET /sells
  # GET /sells.json
  def index
    @search=Sell.search(params[:search])
    @sells = @search.order("created_at desc").page(params[:page]).per(5)

    respond_to do |format|
      format.html # index.html.erb
      format.js{ render :layout => false }
      format.json { render json: @sells }
    end
  end

  # GET /sells/1
  # GET /sells/1.json
  def show
    @sell = Sell.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sell }
    end
  end

  # GET /sells/new
  # GET /sells/new.json
  def new

    @sell = Sell.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sell }
    end
  end

  # GET /sells/1/edit
  def edit
    @sell = Sell.find(params[:id])
  end

  # POST /sells
  # POST /sells.json
  def create

    @sell_price=params[:sell_price].to_f#售价
    @num=params[:num].to_i#数量

    @discount=params[:real_discount].to_f#折扣

    @sell = Sell.new
    @user=User.find_by_number(params[:user_id].to_i)
    @product=Product.find(params[:p_id].to_i)
    @staff=Staff.find(session[:staff_id].to_i)
    @sell.user=@user
    @sell.product=@product
    @sell.staff=@staff
    @sell.status=false

    @integral=0
    if (!params[:integral].blank?)
      @integral=params[:integral].to_i
    end

    @sell.real_discount=@discount*@user.member.discount#实际折扣
    @sell.amount=@num #数量
    @sell.sum=@sell_price 
    @sell.use_integral=@integral
    @sell.actual_sum=@num*(@sell_price*@sell.real_discount)-@integral*@user.member.conversion_rate


    
    respond_to do |format|
      if @sell.save
        format.html { redirect_to @sell, notice: '销售单创建成功！.' }
        format.json { render json: @sell, status: :created, location: @sell }
      else
        format.html { render action: "new" }
        format.json { render json: @sell.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sells/1
  # PUT /sells/1.json
  def update
    @sell = Sell.find(params[:id])

    respond_to do |format|
      if @sell.update_attributes(params[:sell])
        format.html { redirect_to @sell, notice: 'Sell was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sell.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sells/1
  # DELETE /sells/1.json
  def destroy
    @sell = Sell.find(params[:id])
    @sell.destroy

    respond_to do |format|
      format.html { redirect_to sells_url }
      format.json { head :no_content }
    end
  end
  
  #确认销售
  def check_sell

    @sell_id=params[:s_id].to_i
    @amount=params[:amount].to_i
    @sell=Sell.find(@sell_id)
    @actual_sum=params[:actual_sum].to_f

    respond_to do |format|
      if @sell.check_sell(@actual_sum,@amount)
        format.html { redirect_to sells_url, notice: '销售成功！' }
        format.json { head :no_content }
      else
        format.html { render action: "show" }
        format.json { render json: @sell.errors, status: :unprocessable_entity }
      end
    end 
  end
  
  #用户得到自己的购买单
  def sell_user_index
    @sells=Sell.where("user_id = ?",session[:user_id]).order("created_at desc")
  end

  #业务员得到自己某一段时间内的销售量
  #排除取消订单的
  def total_staff_sell
    @search=Sell.search(params[:search])
    @sells = @search.where("staff_id = ? and status = ?",session[:staff_id],false).order("created_at desc").page(params[:page]).per(5) 
    respond_to do |format|
      format.html # index.html.erb
      format.js{ render :layout => false }
      format.json { render json: @sells }
    end
  end

  #管理员查看所有人的销售业绩，
  #排除取消订单的
  def total_staff_all_sell
    @search=Sell.search(params[:search])
    @sells=@search.where("status = ?",false).order("created_at desc").page(params[:page]).per(5) 
    respond_to do |format|
      format.html # index.html.erb
      format.js{ render :layout => false }
      format.json { render json: @sells }
    end
  end

end
