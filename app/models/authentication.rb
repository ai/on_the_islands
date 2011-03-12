class Authentication
  PROVIDERS = { google: 'Google', facebook: 'Facebook', open_id: 'OpenID' }
  
  include Mongoid::Document
  # TODO: include Mongoid::Timestamps::Created
  
  field :provider
  field :uid
  field :used_at, :type => Time
  
  embedded_in :user, :inverse_of => :authentications
  
  validates_presence_of   :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider
  
  def self.from_hash(hash)
    attrs = { provider: hash['provider'], uid: hash['uid'] }
    user = User.where('authentications.provider' => hash['provider'],
                      'authentications.uid' => hash['uid']).first
    user ? user.authentications.where(attrs).first : self.new(attrs)
  end
  
  def self.auth_by_hash(hash)
    auth = self.from_hash(hash)
    auth.used_at = Time.now
    auth
  end
  
  def provider_name
    PROVIDERS[provider.to_sym] || provider
  end
end
