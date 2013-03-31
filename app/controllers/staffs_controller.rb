# coding: utf-8
class StaffsController < ApplicationController
  # GET /staffs
  # GET /staffs.json
  def index
    
    @search = Staff.search(params[:search])
    @staffs = @search.where("staff_type=?",2).page(params[:page]).per(5)
    respond_to do |format|
      format.html # index.html.erb
      format.js{ render :layout => false }
      format.json { render json: @staffs }
    end
  end

  # GET /staffs/1
  # GET /staffs/1.json
  def show
    @staff = Staff.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @staff }
    end
  end

  # GET /staffs/new
  # GET /staffs/new.json
  def new
    @staff = Staff.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @staff }
    end
  end

  # GET /staffs/1/edit
  def edit
    @staff = Staff.find(params[:id])
  end

  # POST /staffs
  # POST /staffs.json
  def create
    @staff = Staff.new(params[:staff])
    @staff=auto_set_value(@staff)
    respond_to do |format|
      if @staff.save
        #启动deplay_jb,使用rake jobs:work ---使用异步发邮件
        AllMailer.delay.welcome_email(@user)
        
        format.html { redirect_to @staff, notice: '员工信息添加成功，初始密码为：123456' }
        format.json { render json: @staff, status: :created, location: @staff }
      else
        format.html { render action: "new" }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /staffs/1
  # PUT /staffs/1.json
  def update
    @staff = Staff.find(params[:id])

    respond_to do |format|
      if @staff.update_attributes(params[:staff])
        format.html { redirect_to @staff, notice: '信息修改成功！' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  #进入密码更新页面
  def update1
    @staff = Staff.new
  end

  #更新密码
  def update2
    if staff = Staff.update_password(params[:oldPassword],params[:staff],params[:id])
    else
      @staff = Staff.new
      render "staffs/update1"
    end
  end

  # DELETE /staffs/1
  # DELETE /staffs/1.json
  def destroy
    @staff = Staff.find(params[:id])
    @staff.destroy

    respond_to do |format|
      format.html { redirect_to staffs_url }
      format.json { head :no_content }
    end
  end

  def reset
    @staff = Staff.find(params[:id])

    respond_to do |format|
     if @staff.update_attributes(:password=>"123456")
        format.html { redirect_to staffs_url, notice: '信息修改成功！' }
        format.js{ render :layout => false }
        format.json { head :no_content }
      else
        format.html { render action: "index" }
        format.js{ render :layout => false }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  def auto_set_value(s)
    if !s.blank?
      s.password="123456"
      @staff = Staff.last
      if !@staff.blank?
        s.number=@staff.number+1
        
        if s.staff_type == nil
          s.staff_type=2
        end
      else
        s.number=10001
      end 
    end
    s
  end

  def pre_update_password

    @staff=Staff.find(session[:staff_id])
    
  end
  
   def update_password
    @s=Staff.new(params[:staff])
    @s_id=params[:s_id].to_i
    @oldpassword=params[:oldpassword]

    respond_to do |format|
      @staff=Staff.find(@s_id)
      if Staff.encrypt_password(@oldpassword, @staff.salt) ==@staff.hash_password
        if @s.password == @s.password_confirmation
          @staff.update_attributes(:password=>@s.password)
          format.html { redirect_to @staff, notice: '密码修改成功.' }
          format.json { head :no_content }
        else
         flash[:notice]="新密码不一致，请重新输入！"
         format.html { redirect_to action: "pre_update_password" }
         format.json { render json: @staff.errors, status: :unprocessable_entity }  
        end
      else
         flash[:notice]="旧密码输入不正确，请重新输入！"
         format.html { redirect_to action: "pre_update_password" }
         format.json { render json: @staff.errors, status: :unprocessable_entity } 
      end
    end

  end

end
