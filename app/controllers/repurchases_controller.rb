# coding: utf-8
class RepurchasesController < ApplicationController
  # GET /repurchases
  # GET /repurchases.json
  def index
    @search=Repurchase.search(params[:search])
    @repurchases = @search.order("created_at desc").page(params[:page]).per(5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @repurchases }
    end
  end

  # GET /repurchases/1
  # GET /repurchases/1.json
  def show
    @sell = Sell.find(params[:id])
    @repurchase = Repurchase.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @repurchase }
    end
  end

  # GET /repurchases/new
  # GET /repurchases/new.json
  def new
    @repurchase = Repurchase.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @repurchase }
    end
  end

  # GET /repurchases/1/edit
  def edit
    @repurchase = Repurchase.find(params[:id])
  end

  # POST /repurchases
  # POST /repurchases.json
  def create
    @repurchase = Repurchase.new(params[:repurchase])

    respond_to do |format|
      if @repurchase.save
        format.html { redirect_to @repurchase, notice: 'Repurchase was successfully created.' }
        format.json { render json: @repurchase, status: :created, location: @repurchase }
      else
        format.html { render action: "new" }
        format.json { render json: @repurchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /repurchases/1
  # PUT /repurchases/1.json
  def update
    @repurchase = Repurchase.find(params[:id])

    respond_to do |format|
      if @repurchase.update_attributes(params[:repurchase])
        format.html { redirect_to @repurchase, notice: 'Repurchase was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @repurchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repurchases/1
  # DELETE /repurchases/1.json
  def destroy
    @repurchase = Repurchase.find(params[:id])
    @repurchase.destroy

    respond_to do |format|
      format.html { redirect_to repurchases_url }
      format.json { head :no_content }
    end
  end

  #处理退货
  def handle_resell
    @s_id=params[:s_id].to_i
    @u_id=params[:u_id].to_i
    @joinp=params[:joinP]
    # @sum=params[:sum].to_f #购买价格
    # @amount=params[:amount].to_i #退货数量
    # @actual_sum=params[:actual_sum].to_i

    @repurchase=Repurchase.new(params[:repurchase])
    @sell=Sell.find(@s_id)
    @repurchase.user=User.find(@u_id)
    @repurchase.sell=@sell
    @repurchase.staff=Staff.find(session[:staff_id])

    # @repurchase.sum=@sum
    # @repurchase.actual_sum=@actual_sum
    # @repurchase.amount=@amount
    @product=Product.find(@sell.product.id)

    if @joinp == "t"
        @product.update_attributes(:stock_quantity=>@product.stock_quantity+@repurchase.amount)
    end

    respond_to do |format|
      if @repurchase.save
        
        @sell.update_attributes(:status=>true)
       
        format.html { redirect_to repurchases_url, notice: '退货单处理完成！' }
        format.json { render json: @repurchase, status: :created, location: @repurchase }
      else
        format.html { render action: "show" }
        format.json { render json: @repurchase.errors, status: :unprocessable_entity }
      end
    end

  end

end
