require 'spec_helper'

describe User do

  describe "#generate_login" do
  
    it "should generate login from e-mail" do
      User.generate_login('test@example.com', 'http://a.com').should == 'test'
    end
    
    it "should generate login from OpenID if e-mail is empty" do
      User.generate_login('', 'http://example.com').should == 'example.com'
    end
    
    it "should generate login from OpenID if e-mail is short" do
      User.generate_login('i@example.com', 'http://a.com').should == 'a.com'
    end
    
    it "should generate login from HTTPS OpenID" do
      User.generate_login('', 'https://example.com').should == 'example.com'
    end
    
    it "should add postfix if login is busy" do
      Factory(:user, :login => 'test')
      User.generate_login('test@example.com', '').should == 'test2'
      
      Factory(:user, :login => 'test2')
      User.generate_login('test@example.com', '').should == 'test3'
    end
  
  end
  
  describe "#avatar" do
  
    it "should return gravatar URL" do
      user = Factory(:user, :email => 'andrey@sitnik.ru')
      md5 = 'cd32d17c95d3bfb352504c36462b98bd'
      user.avatar.should ==
        "http://gravatar.com/avatar/#{md5}?s=50&d=identicon"
      user.avatar(100).should ==
        "http://gravatar.com/avatar/#{md5}?s=100&d=identicon"
    end
  
  end
  
end
