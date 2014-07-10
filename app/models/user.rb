class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  before_save :email_from_username
         
  def email_required? 
    false
  end
  
  protected
  
  def email_from_username
    self.email = "#{self.username}@parature.com"
  end
  
end
