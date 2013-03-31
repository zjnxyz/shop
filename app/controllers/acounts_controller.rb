# coding: utf-8
class AcountsController < ApplicationController
  skip_before_filter :require_login

  # GET /acounts
  # GET /acounts.json
  def index
    @acounts = Acount.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @acounts }
    end
  end

  # GET /acounts/1
  # GET /acounts/1.json
  def show
    @acount = Acount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @acount }
    end 
  end

  # GET /acounts/new
  # GET /acounts/new.json
  def new
    @acount = Acount.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @acount }
    end
  end

  # GET /acounts/1/edit
  def edit
    @acount = Acount.find(params[:id])
  end

  # POST /acounts
  # POST /acounts.json
  def create
    @acount = Acount.new(params[:acount])

    respond_to do |format|
      if @acount.save
        format.html { redirect_to @acount, notice: 'Acount was successfully created.' }
        format.json { render json: @acount, status: :created, location: @acount }
      else
        format.html { render action: "new" }
        format.json { render json: @acount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /acounts/1
  # PUT /acounts/1.json
  def update
    @acount = Acount.find(params[:id])

    respond_to do |format|
      if @acount.update_attributes(params[:acount])
        format.html { redirect_to @acount, notice: 'Acount was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @acount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acounts/1
  # DELETE /acounts/1.json
  def destroy
    @acount = Acount.find(params[:id])
    @acount.destroy

    respond_to do |format|
      format.html { redirect_to acounts_url }
      format.json { head :no_content }
    end
  end

  def pre_user_app_find_password
      
  end

  def user_app_find_password
    if User.auth_has_user(params[:number])
      user=User.authenticate(params[:number],0)
      @acount=Acount.new
      @acount.hash_url=Acount.ge_hash_url(user.name)
      @acount.u_id=user.id
      @acount.acount_type=2 #用户找回密码

      respond_to do |format|
        if @acount.save
          
           #启动deplay_jb,使用rake jobs:work ---使用异步发邮件
          AllMailer.delay.modify_password(user,@acount)

          flash[:notice]="邮件已发送到你的邮件，请在两个小时内修改密码"
          format.html { render action: "pre_user_app_find_password"}
          format.json { render json: @acount, status: :created, location: @acount }
        else
          flash[:notice]="出现错误了。。。"
          format.html { render action: "pre_user_app_find_password" }
          format.json { render json: @acount.errors, status: :unprocessable_entity }
        end
      end

    else
      flash[:notice]="你输入的账号不存在，请检查后重新输入"
      render action: "pre_user_app_find_password"
    end

  end

  def pre_user_modify_password

    @hash_url=params[:id]
    @acount=Acount.find_by_hash_url(@hash_url)
    @user=User.find(@acount.u_id)
    
    if !@acount.blank?
      if Time.new-@acount.created_at < 2.hour

      else
         flash[:notice]="对不起，申请时间已超过2小时，链接失效，请重新申请"
         render action: "pre_user_app_find_password"
      end
    else
      flash[:notice]="对不起，你申请的修改密码不存在，请您重新申请！"
      render action: "pre_user_app_find_password"
    end
    
  end

  def user_modify_password
    @u_id=params[:u_id].to_i
    @password1=params[:password1]
    @password2=params[:password2]
    @user=User.find(@u_id)

    if !@user.blank?
      if @password1 == @password2
        @user.update_attributes(:password=>@password1)
        flash[:notice]="密码修改成功！请重新登录。。。。"
      else
        flash[:notice]="两次密码输入不一致"
        render action: "pre_user_modify_password"
      end    
    end   
  end

  def pre_staff_app_find_password
    
  end

  def staff_app_find_password
    if staff=Staff.auth_has_staff(params[:number])
      @acount=Acount.new
      @acount.hash_url=Acount.ge_hash_url(staff.name)
      @acount.u_id=staff.id
      @acount.acount_type=1 #管理员找回密码

      respond_to do |format|
        if @acount.save
          
           #启动deplay_jb,使用rake jobs:work ---使用异步发邮件
          AllMailer.delay.staff_modify_password(staff,@acount)

          flash[:notice]="邮件已发送到你的邮件，请在两个小时内修改密码"
          format.html { render action: "pre_staff_app_find_password"}
          format.json { render json: @acount, status: :created, location: @acount }
        else
          flash[:notice]="出现错误了。。。"
          format.html { render action: "pre_staff_app_find_password" }
          format.json { render json: @acount.errors, status: :unprocessable_entity }
        end
      end

    else
      flash[:notice]="你输入的账号不存在，请检查后重新输入"
      render action: "pre_staff_app_find_password"
    end

  end

  def pre_staff_modify_password

    @hash_url=params[:id]
    @acount=Acount.find_by_hash_url(@hash_url)
    @staff=Staff.find(@acount.u_id)
    
    if !@acount.blank?
      if Time.new-@acount.created_at < 2.hour

      else
         flash[:notice]="对不起，申请时间已超过2小时，链接失效，请重新申请"
         render action: "pre_staff_app_find_password"
      end
    else
      flash[:notice]="对不起，你申请的修改密码不存在，请您重新申请！"
      render action: "pre_staff_app_find_password"
    end  
  end

  def staff_modify_password
    @u_id=params[:u_id].to_i
    @password1=params[:password1]
    @password2=params[:password2]
    @staff=Staff.find(@u_id)

    if !@staff.blank?
      if @password1 == @password2
        @staff.update_attributes(:password=>@password1)
        flash[:notice]="密码修改成功！请重新登录。。。。"
      else
        flash[:notice]="两次密码输入不一致"
        render action: "pre_staff_modify_password"
      end    
    end   
  end


end
