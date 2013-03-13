class Product < ActiveRecord::Base
  #商品表
  #上传
  mount_uploader :img_url, AvatarUploader
  belongs_to :unit
  belongs_to :category
  belongs_to :brand
  has_many :orders
  has_many :sells
  has_many :images
               #头像，是否提成，是否为三下乡产品，
               #姓名，编号，超额提成比例
               #最低售价，拼音缩写，进货价格
               #预售价，状态（blooean）， 库存下限，库存数量
               #补贴比例，商品简介 ,销售量 ， 大图片 ,折扣
  attr_accessible :brand, :category, :unit, :img_url, :is_percentage, :is_rural_areas,
                  :name, :number, :over_royalty_percentage,
                  :percentage_price, :pinyin_initials, :purchase_price,
                  :sell_price, :status, :stock_lower_limit, :stock_quantity,
                  :subsidies_proportion, :summary, :sales_volume,:big_imgurl,:discount,:img_url_cache

  validates :number,:name, :uniqueness =>true,:presence => true
  validates :over_royalty_percentage, :percentage_price,:sell_price,:purchase_price, :numericality => true,:presence => true

end
