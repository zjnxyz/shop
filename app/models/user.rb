class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  #用户表
  belongs_to :member
  has_many :orders,:dependent => :destroy
  has_many :repurchases,:dependent => :destroy
  has_many :sells,:dependent => :destroy

               #邮箱，积分，姓名，编号，手机，拼音缩写，备注....,用户名
  attr_accessible :email, :integral, :name, :number, :phone, :pinyin_initials, :remark, :member,
                  :hash_password,:salt,:password,:username
  attr_reader :password

  validates  :email, :presence => true, :uniqueness =>true
  #validates  :number, :presence => true, :uniqueness =>true
  validates  :username, :presence => true, :uniqueness =>true
  validates  :phone, :presence => true, :uniqueness =>true
  validates  :password, :confirmation =>true
  validates  :name, :presence => true

  def User.auth_has_user(number)
    if user=User.find_by_number(number)||user=User.find_by_email(number)||user=User.find_by_phone(number)
      true
    end
  end

  def User.authenticate(number,password)
    if user=User.find_by_number(number)||user=User.find_by_email(number)||user=User.find_by_phone(number)
      if password != 0
        if user.hash_password == encrypt_password(password, user.salt)
          user
        end
      else
        user
      end
     
    end
  end

  def User.encrypt_password(password, salt)
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

      @user = User.last
      if !@user.blank?
        #self.number=@user.number+1
        if @user.member.blank?
          @user.member == Member.first
        end
      else

        self.number=2000001
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
