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
        	@sells=Sell.where("created_at>=? and created_at<=? ",@start_time,@end_time)
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
        else
           @sells=Sell.where("created_at>=? and created_at<=? and staff_id=?",@start_time,@end_time,@s_id) 
           @staff=Staff.find(@s_id);
           @sells_group=@sells.group_by{|s| s.created_at.to_date()}
           @sells_group.each do |date,sells2|
                @amount_all=0 #每天总的销售量
                @sum_all=0#每天总的销售金额
                @d1=Array.new
                @d2=Array.new
                sells2.each do |s|
                    @amount_all=@amount_all+s.amount
                    @sum_all=@sum_all+s.actual_sum 
                end

                @d1.push(date);
                @d1.push(@amount_all)
                @data1.push(@d1)

                @d2.push(date);
                @d2.push(@sum_all.to_i)
                @data2.push(@d2)

           end
        end

		respond_to do |format|
	       format.html # staff_chart.html.erb
	       format.js{ render :layout => false }
	    end
		
	end


    def pre_cate_chart
        
    end

    def find_product_by_cate
        @c_id=params[:c_id].to_i
        @products=Product.where("category_id=?",@c_id);
        respond_to do |format|
          format.json { render :json=>@products }
        end
    end

    def cate_chart
        @start_time=params[:start_time].to_time
        @end_time=params[:end_time].to_time
        @c_id=params[:c_id].to_i
        @p_id_str=params[:p_id]
        @p_id=0 
        if !@p_id_str.blank?
            @p_id = @p_id_str.to_i

        end

        @sells= Array.new
        @data1=Array.new
        @data2=Array.new

        if @p_id==0
            @category=Category.find(@c_id)
            @products=Product.where("category_id=?",@c_id);
            @products.each do |p|
              @sells=@sells+Sell.where("created_at>=? and created_at<=? and product_id=?",@start_time,@end_time,p.id)   
            end
            
            @sells_group=@sells.group_by{|s| s.product}
            @sells_group.each do |product,sells2|
                @amount_all=0 #商品总的销售量
                @sum_all=0#商品总的销售金额
                @d1=Array.new
                @d2=Array.new
                sells2.each do |s|
                    @amount_all=@amount_all+s.amount
                    @sum_all=@sum_all+s.actual_sum 
                end

                @d1.push(product.id)
                @d1.push(@amount_all)
                @data1.push(@d1)

                @d2.push(product.id);
                @d2.push(@sum_all.to_i)
                @data2.push(@d2)

           end
        else
            @product=Product.find(@p_id)
            @sells=Sell.where("created_at>=? and created_at<=? and product_id=?",@start_time,@end_time,@p_id)
            @sells_group=@sells.group_by{|s| s.created_at.to_date()}
            @sells_group.each do |date,sells2|
                @amount_all=0 #每天某件商品总的销售量
                @sum_all=0#每天某件商品总的销售金额
                @d1=Array.new
                @d2=Array.new
                sells2.each do |s|
                    @amount_all=@amount_all+s.amount
                    @sum_all=@sum_all+s.actual_sum 
                end

                @d1.push(date);
                @d1.push(@amount_all)
                @data1.push(@d1)

                @d2.push(date);
                @d2.push(@sum_all.to_i)
                @data2.push(@d2)
            end
        end
    end

    #按照品牌来得到统计图表
    def pre_brand_chart
        
    end

    def find_product_by_brand
        @b_id=params[:b_id].to_i
        @products=Product.where("brand_id=?",@b_id);
        respond_to do |format|
          format.json { render :json=>@products }
        end
    end

    def brand_chart

        @start_time=params[:start_time].to_time
        @end_time=params[:end_time].to_time
        @b_id=params[:b_id].to_i
        @p_id_str=params[:p_id]
        @p_id=0 
        if !@p_id_str.blank?
            @p_id = @p_id_str.to_i

        end

        @sells= Array.new
        @data1=Array.new
        @data2=Array.new

        if @p_id==0
            @brand=Brand.find(@b_id)
            @products=Product.where("brand_id=?",@b_id);
            @products.each do |p|
              @sells=@sells+Sell.where("created_at>=? and created_at<=? and product_id=?",@start_time,@end_time,p.id)   
            end
            
            @sells_group=@sells.group_by{|s| s.product}
            @sells_group.each do |product,sells2|
                @amount_all=0 #商品总的销售量
                @sum_all=0#商品总的销售金额
                @d1=Array.new
                @d2=Array.new
                sells2.each do |s|
                    @amount_all=@amount_all+s.amount
                    @sum_all=@sum_all+s.actual_sum 
                end

                @d1.push(product.id)
                @d1.push(@amount_all)
                @data1.push(@d1)

                @d2.push(product.id);
                @d2.push(@sum_all.to_i)
                @data2.push(@d2)

           end
        else
            @product=Product.find(@p_id)
            @sells=Sell.where("created_at>=? and created_at<=? and product_id=?",@start_time,@end_time,@p_id)
            @sells_group=@sells.group_by{|s| s.created_at.to_date()}
            @sells_group.each do |date,sells2|
                @amount_all=0 #每天某件商品总的销售量
                @sum_all=0#每天某件商品总的销售金额
                @d1=Array.new
                @d2=Array.new
                sells2.each do |s|
                    @amount_all=@amount_all+s.amount
                    @sum_all=@sum_all+s.actual_sum 
                end

                @d1.push(date);
                @d1.push(@amount_all)
                @data1.push(@d1)

                @d2.push(date);
                @d2.push(@sum_all.to_i)
                @data2.push(@d2)
            end
        end
        
    end


end

