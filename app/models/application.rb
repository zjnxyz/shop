class Application < ActiveRecord::Base
  belongs_to :sell
  belongs_to :user
  belongs_to :staff
  #是否处理：true表示处理、false表示未处理， 备注，申请类型，1-表示保修、2-维修、3-申请退货
  attr_accessible :is_handle, :remark,:app_type, :type
end
