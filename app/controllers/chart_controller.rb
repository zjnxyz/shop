# coding: utf-8
class ChartController < ApplicationController

    #员工的销售图表

    def pre_staff_chart
    	
    end

	def staff_chart
        @start_time=params[:start_time].to_time
        @end_time=params[:end_time].to_time
        @s_id_str=params[:s_id]
        @s_id=0 
        if !@s_id_str.blank?
        	@s_id = @s_id_str.to_i
        end

        @sells= Array.new
        @data1=Array.new
        @data2=Array.new
        if @s_id==0
        	@sells=Sell.where("created_at>? and created_at<? ",@start_time,@end_time)
        	@sells_group=@sells.group_by{|s| s.staff}
        	@sells_group.each do |staff,sells2|
        		@amount_all=0 #总的销售量

        		@sum_all=0#总的销售金额
                @d1=Array.new
                @d2=Array.new

        		sells2.each do |s|
                 @amount_all=@amount_all+s.amount
                 @sum_all=@sum_all+s.actual_sum 
        		end

        		@d1.push(staff.id);
        		@d1.push(@amount_all)
        		@data1.push(@d1)

        		@d2.push(staff.id);
        		@d2.push(@sum_all.to_i)
        		@data2.push(@d2)

        	end
        end

		respond_to do |format|
	       format.html # staff_chart.html.erb
	       format.js{ render :layout => false }
	    end
		
	end


end

