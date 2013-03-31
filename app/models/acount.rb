class Acount < ActiveRecord::Base

  #acount_type:用户类型，1-管理员和员工，2-会员，hash_url:用户名和时间生成的一个hash值
  #u_id 用户的id
  attr_accessible :acount_type, :hash_url, :u_id

  #产生hash_url
  def self.ge_hash_url(name)
  	 Digest::SHA2.hexdigest(name+"wibble"+self.object_id.to_s+rand.to_s)
  end
end
