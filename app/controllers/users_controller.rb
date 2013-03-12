# coding: utf-8
class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @search = User.search(params[:search])
    @users = @search.page(params[:page]).per(5)
    respond_to do |format|
      format.html # index.html.erb
      format.js{ render :layout => false }
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      if Member.all.blank?
           format.html{redirect_to "/members/new",notice: "请添加会员类型！"}
      else

          format.html # new.html.erb
          format.json { render json: @user }
      end
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    
    if !params[:member_id].blank?
      @member = Member.find(params[:member_id])
      @user.member = @member
    end
    @user=auto_set_value(@user)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: '会员创建成功.初始密码是123456' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    @member_id=params[:member_id]
  
    respond_to do |format|
      if @user.update_attributes(params[:user])
        if !@member_id.blank?
          @member=Member.find(@member_id.to_i)
          @user.update_attributes(:member=>@member)   
        end
        format.html { redirect_to @user, notice: '会员修改成功.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to "/welceom/index" }
      format.json { head :no_content }
    end
  end

  #通过会员编号查询会员信息
  def query_by_number
    @user=User.find_by_number(params[:uid].to_i)
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { render :json=>@user }
    end
  end

  def reset
    @user = User.find(params[:id])

    respond_to do |format|
     if @user.update_attributes(:password=>"123456")
        format.html { redirect_to users_url, notice: '密码重置成功，初始密码为：123456！' }
        format.js{ render :layout => false }
        format.json { head :no_content }
      else
        format.html { render action: "index" }
        format.js{ render :layout => false }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def auto_set_value(s)
    if !s.blank?
      s.password="123456"

      @user = User.last
      if !@user.blank?
        s.number=@user.number+1
        if @user.member.blank?
          @user.member == Member.first
        end
      else

        s.number=2000001
      end 
    end
    s
  end

  def pre_update_password
    @user=User.find(session[:user_id])
  end

  def update_password
    @u=User.new(params[:user])
    @u_id=params[:u_id].to_i
    @oldpassword=params[:oldpassword]

    respond_to do |format|
      @user=User.find(@u_id)
      if User.encrypt_password(@oldpassword, @user.salt) ==@user.hash_password
        if @u.password == @u.password_confirmation
          @user.update_attributes(:password=>@u.password)
          format.html { redirect_to @user, notice: '密码修改成功.' }
          format.json { head :no_content }
        else
         flash[:notice]="新密码不一致，请重新输入！"
         format.html { redirect_to action: "pre_update_password" }
         format.json { render json: @user.errors, status: :unprocessable_entity }  
        end
      else
         flash[:notice]="旧密码输入不正确，请重新输入！"
         format.html { redirect_to action: "pre_update_password" }
         format.json { render json: @user.errors, status: :unprocessable_entity } 
      end
    end

  end

end
