# coding: utf-8
class ApplicationsController < ApplicationController
  # GET /applications
  # GET /applications.json
  def index
    @applications=Application.all
    # @search=Application.search(params[:search])
    # @applications = Application.where("is_handle = ?",false).page(params[:page]).per(5)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applications }
    end
  end

  def see_staff
    @search=Application.search(params[:search])
    @applications =Application.where("is_handle = ?",false).page(params[:page]).per(5)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applications }
    end
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
    @application = Application.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @application }
    end
  end

  # GET /applications/new
  # GET /applications/new.json
  def new
    @application = Application.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @application }
    end
  end

  # GET /applications/1/edit
  def edit
    @application = Application.find(params[:id])
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = Application.new(params[:application])
    @application.sell=Sell.find(params[:sell_id])
    @application.user=User.find(session[:user_id])
    @application.is_handle=false

    respond_to do |format|
      if @application.save
        format.html { redirect_to action: :index_user, notice: '申请单创建成功.' }
        format.json { render json: @application, status: :created, location: @application }
      else
        format.html { render action: "new" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /applications/1
  # PUT /applications/1.json
  def update
    @application = Application.find(params[:id])

    respond_to do |format|
      if @application.update_attributes(params[:application])
        format.html { redirect_to @application, notice: '申请单修改成功.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application = Application.find(params[:id])
    @application.destroy

    respond_to do |format|
      if !session[:user_id].blank?

        @applications=Application.where("user_id = ?",session[:user_id]).order("created_at desc") 
        format.js{ render :layout => false }
        format.json { head :no_content }
      elsif !session[:staff_id].blank?
        format.html { redirect_to applications_url }
        format.json { head :no_content }
      end
      
    end
  end

  #得到用户的申请清单
  def index_user
    @applications=Application.where("user_id = ?",session[:user_id]).order("created_at desc") 
  end

  #直接创建申请
  #applications/:id/create,:method =>:get
  def pre_create_app
    @sell=Sell.find(params[:id].to_i)
    @application=Application.new

  end

end
