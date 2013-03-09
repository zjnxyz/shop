# coding: utf-8
module ApplicationsHelper
	def t_app_type(app_type)
       if app_type.to_i==1
       	  "维修"
       elsif app_type.to_i==2
       	  "保修"
       	elsif app_type.to_i==3
       	  "退货"
       end	
	end

	def t_stutas(status)
		if status
			"已处理!"
	    else
            "等待处理中......"
		end
		
	end
end
