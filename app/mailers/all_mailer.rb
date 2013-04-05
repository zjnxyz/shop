# coding: utf-8
class AllMailer < ActionMailer::Base
  default from: "zjnxyz <zjn100002@126.com>"

  def welcome_email(user)
  	@u=user
  	@url="http://127.0.0.1:3000"
  	mail to: @u.email, subject: "欢迎来到家电商场管理系统"
  end

  #修改密码的邮件
  def modify_password(user,acount)
  	@user=user
  	@acount = acount
    @url="http://127.0.0.1:3000/acounts/"+@acount.hash_url+"/pre_user_modify_password"  
  	mail to: @user.email, subject: "[系统邮件]家电商场管理系统-----请勿回复"
  end

   #管理员修改密码的邮件
  def staff_modify_password(staff,acount)
    @staff=staff
    @acount = acount
    @url="http://127.0.0.1:3000/acounts/"+@acount.hash_url+"/pre_staff_modify_password"
    mail to: @staff.eamil, subject: "[系统邮件]家电商场管理系统-----请勿回复"
  end

end
