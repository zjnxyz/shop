# coding: utf-8
class Staff < ActiveRecord::Base
  #上传
  mount_uploader :img_url, AvatarUploader
  #员工表
  has_many :repurchases,:dependent => :destroy
  has_many :sells,:dependent => :destroy
    #地址，补助，出生年月， 身份证，邮件，
    #头像， 最低工资， 姓名， 员工编号，电话
    #拼音缩写，备注，性别，开始工作时间 ,员工类型（1-管理员，2-业务员,头像
  attr_accessible :address, :allowance, :birthday, :card_id, :email,
                  :img_url, :low_salary, :name, :number, :phone,
                  :pinyin_initials, :remark, :sex, :start_work_time,:type,
                  :hash_password,:salt,:password_confirmation,:password,:staff_type,:pic,:img_url_cache
  attr_reader :password

  validates  :email, :presence => true, :uniqueness =>true
  #validates  :number, :presence => true, :uniqueness =>true
  validates  :password, :confirmation =>true
  #工资和补助都为数字
  validates :allowance, :low_salary, :numericality => true
  validates :name,:presence => true,:length => { :minimum => 2 }
  validates :phone, :birthday, :card_id,:start_work_time,:presence => true
 
  #validate :password_must_be_present

  def Staff.authenticate(number,password)
    if staff = find_by_number(number) || staff = find_by_card_id(number) || staff = find_by_phone(number) || find_by_email(number)
      if staff.hash_password ==  encrypt_password(password, staff.salt)
        staff
      end
    end
  end

  def Staff.update_password(oldPassword,staff,id)
    @staff = Staff.find(id)
    if @staff.hash_password == encrypt_password(oldPassword, @staff.salt)
       @staff.update_attributes(staff)
       staff = Staff.find(id)
       staff
    end
  end


  def Staff.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password+"wibble"+salt)
  end

  def password=(password)
    @password = password
    if password.present?
      generate_salt
      self.hash_password = self.class.encrypt_password(password, salt)
    end
  end

  #before_save :auto_set_value
  def auto_set_value
    if !self.blank?
      self.password="123456"
      @staff = Staff.last
      if !@staff.blank?
        self.number=@staff.number+1
        
        if self.staff_type == nil
          self.staff_type=2
        end

      else

        self.number=10001
      end 
    end
  end

  private
  def password_must_be_present
    errors.add(:password,"Missing password") unless hash_password.present?
  end

  def generate_salt
    self.salt = self.object_id.to_s+rand.to_s
  end

end
