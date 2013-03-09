# coding: utf-8
module AdminHelper
  def admin_log
    @name="无人登录"
    if session[:staff_id] != nil
        @staff = Staff.find(session[:staff_id])
        @name = @staff.name
        if @staff.staff_type == 1
          @name +" 管理员"
        else
          @name +"业务员"
        end
    elsif session[:user_id] != nil
        @user=User.find(session[:user_id])
        if !@user.blank?
           @name=@user.name<<@user.member.name
        end
    else
      @name
    end
  end
  
end
