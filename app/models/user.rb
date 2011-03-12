require 'digest/md5'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :login
  field :name
  field :email
  field :session_token
  
  embeds_many :authentications
  
  index ['authentications.provider', 'authentications.uid'], unique: true
  
  validates :login, presence: true, length: { minimum: 2 }, uniqueness: true,
                    format: /^[\w\d\.-]+$/
  validates :email, presence: true, email: true, uniqueness: true
  
  before_create :generate_session_token
  
  def self.build_from_auth(hash, auth)
    User.new do |u|
      u.name  = hash['user_info']['name']
      u.email = hash['user_info']['email']
      u.login = generate_login(u.email, hash['uid'])
      u.authentications = [auth]
    end
  end
  
  def self.generate_login(email, openid)
    login = ''
    login = prefix = loginize(email.sub(/@[^@]+$/, '')) if email
    login = prefix = loginize(openid.gsub(/^https?/, '')) if login.length < 2
    i = 1
    login = prefix + (i += 1).to_s until User.where(login: login).count.zero?
    login
  end
  
  def self.loginize(string)
    string.gsub(/[^\w\d\.-]/, '').downcase
  end
  
  def generate_session_token
    self.session_token = ActiveSupport::SecureRandom.base64(15)
  end
  
  def avatar(size = 50)
    return unless self.email
    'http://gravatar.com/avatar/' +
      Digest::MD5.hexdigest(self.email) + "?s=#{size}&d=identicon"
  end
end
