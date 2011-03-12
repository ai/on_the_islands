Rails.application.config.middleware.use OmniAuth::Builder do
  require 'openid/store/filesystem'
  tmp = OpenID::Store::Filesystem.new('/tmp')
  provider :open_id,  tmp, name: 'google',
                      identifier: 'https://www.google.com/accounts/o8/id'
  provider :facebook, '186455268054061', '14cbfa4e676acb7b1353f88ec5d6daa4'
  provider :open_id,  tmp
end
