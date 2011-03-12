require 'spec_helper'

describe Authentication do

  describe "#provider_name" do
  
    it "should return provider name" do
      Authentication.new(provider: 'google').provider_name.should   == 'Google'
      Authentication.new(provider: 'facebook').provider_name.should == 'Facebook'
      Authentication.new(provider: 'open_id').provider_name.should  == 'OpenID'
      Authentication.new(provider: 'unknow').provider_name.should   == 'unknow'
    end
  
  end
  
end
