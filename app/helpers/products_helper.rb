# coding: utf-8
module ProductsHelper
  def product_status(status)
       if status == nil || status == false
         "未启用"
       else
         "启用"
       end
  end

  def product_is_rural_areas(areas)
    if areas == nil  || areas==false
      "否"
    else
      "是"
    end
  end

  def product_stock_lower_limit (limit)
    if limit == nil
      "0"
    else
      limit
    end
  end

   


end
