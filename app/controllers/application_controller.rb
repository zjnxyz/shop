# coding: utf-8
class ApplicationController < ActionController::Base
  # layout :detemine_layout
  protect_from_forgery
  before_filter :require_login
  # def detemine_layout
  #   if session[:staff_id] == nil && session[:user] == nil
  #     "welcome"
  #   elsif session[:user] != nil
  #     "user"
  #   elsif session[:staff_id] != nil && Staff.find_by_id(session[:staff_id]).staff_type ==1
  #     "staffM1"
  #   elsif session[:staff_id] != nil && session[:staff].staff_type ==2
  #     "staffM2"
  #   end
  # end

  private

  # 通过键 :current_user_id 查找含有存储在 session 中的 ID 的 User 。
  # 这是一种在 Rails 应用中处理用户登录的常见方式；登录时设置几组 session 值
  # 然后登出时移除之。
  def current_user

    @_current_user ||= session[:user_id] &&
        User.find_by_id(session[:user_id])  unless session[:user_id] == nil

    @_current_user ||= session[:staff_id] &&
        Staff.find_by_id(session[:staff_id])  unless session[:staff_id] == nil
  end

  def require_login

    if !login_in
      flash[:error] = "对不起，您还没有登录无权访问该页面"
      redirect_to "/welcome/index"
    end
    
  end

  def login_in
    if !session[:user_id].blank? || !session[:staff_id].blank?
       true
    else
      false
    end
  end
end
