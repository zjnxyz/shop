# coding: utf-8
module SellsHelper
	def format_resell(status)
		@s="已退货"
		if status
			@s
		else
			@s="交易成功"
		end
		@s
	end

	def count_percen(low_price,sell_price,royalty,amoumt)
		@money=0
		@money = (sell_price-low_price*amoumt)*royalty
		@money
	end
end
