# coding: utf-8
class UnitsController < ApplicationController
  # GET /units
  # GET /units.json
  def index
    @units = Unit.all
    @unit = Unit.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @units }
    end
  end

  # GET /units/1
  # GET /units/1.json
  def show
    @unit = Unit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @unit }
    end
  end

  # GET /units/new
  # GET /units/new.json
  def new
    @unit = Unit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @unit }
    end
  end

  # GET /units/1/edit
  def edit
    @unit = Unit.find(params[:id])
  end

  # POST /units
  # POST /units.json
  def create
    @unit = Unit.new(params[:unit])

    respond_to do |format|
      if @unit.save
        format.html { redirect_to units_url, notice: '单位成功创建！' }
        format.json { render json: units_url, status: :created, location: @unit }
      else
        format.html { render action: "new" }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /units/1
  # PUT /units/1.json
  def update
    @unit = Unit.find(params[:id])

    respond_to do |format|
      if @unit.update_attributes(params[:unit])
        format.html { redirect_to units_url, notice: '更新单位成功！' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1
  # DELETE /units/1.json
  def destroy
    @unit = Unit.find(params[:id])
    @unit.destroy

    respond_to do |format|
      format.html { redirect_to units_url }
      format.json { head :no_content }
    end
  end

  def delete
    @unit = Unit.find(params[:id])
    @unit.destroy

    respond_to do |format|
      format.html { redirect_to units_url }
      format.json { head :no_content }
    end
  end

  #过滤器，表示只有管理员才能访问units有关的页面
  before_filter :require_manage
  def require_manage
    if !is_manage
      flash[:error] = "对不起，您还无权访问该页面"
      redirect_to "/welcome/index"
    end
  end

  def is_manage
    if session[:staff_id].blank?
      false
    else
      @staff=Staff.find(session[:staff_id])
      if @staff.staff_type==1
        true
      else
        false
      end 
    end
  end

end
