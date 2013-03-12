# coding: utf-8
class SessionsController < ApplicationController
  #layout "welcome"
  skip_before_filter :require_login
  def new
  end

  def create
    if staff =  Staff.authenticate(params[:number],params[:password])
      session[:staff_id] = staff.id
      redirect_to "/admin/index"
    else
      redirect_to "/sessions/new", :notice => '用户名或密码错误'
    end
  end
  
  #管理员或员工退出
  def destroy
    session[:staff_id] = nil
    redirect_to "/welcome/index", :notice => "Logged out"
  end
  #进入会员登录页面
  def new_user
  end
  #会员登录
  def create_user
    if user=User.authenticate(params[:number],params[:password])
     session[:user_id]=user.id
     redirect_to "/admin/index"
    else
      redirect_to "/sessions/new_user", :notice => '用户名或密码错误'
    end
  end

  #管理员或员工退出
  def destroy_user
    session[:user_id] = nil
    redirect_to "/welcome/index", :notice => "Logged out"
  end

end
