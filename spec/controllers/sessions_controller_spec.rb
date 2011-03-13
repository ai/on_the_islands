require 'spec_helper'

describe SessionsController do
  
  describe "#create" do
  
    before :each do
      @fake = {
        'provider' => 'fake', 'uid' => 'john',
        'user_info' => { 'name' => 'John Smith', 'email' => 'john@example.com' }
      }
      controller.stub!(:auth_hash).and_return(@fake)
      
      @time_now = Time.parse('Jan 1 2001').utc
      Time.stub!(:now).and_return(@time_now)
    end
    
    it "should create new user" do
      User.count.should be_zero
      
      get :create, provider: 'fake'
      
      response.should redirect_to(root_url)
      
      User.count.should == 1
      user = assigns(:user)
      user.name.should  == 'John Smith'
      user.email.should == 'john@example.com'
      user.login.should == 'john'
      user.should have(1).authentication
      
      auth = assigns(:auth)
      auth.provider.should     == 'fake'
      auth.uid.should          == 'john'
      auth.used_at.utc.should  == @time_now
      
      flash[:notice].should include("generate login #{user.login}")
      session[:session_token].should == user.session_token
    end
    
    it "should signin exists user" do
      user = Factory(:user, authentications: [{provider: 'fake', uid: 'john'}])
      User.count.should == 1
      
      get :create, provider: 'fake'
      
      User.count.should == 1
      assigns(:user).should == user
      session[:session_token].should == user.session_token
      assigns(:auth).used_at.utc.should  == @time_now
    end
    
    it "shouldn't create double authorization" do
      user = Factory(:user, authentications: [{provider: 'fake', uid: 'john'}])
      session[:session_token] = user.session_token
      
      get :create, provider: 'fake'
      
      assigns(:user).should have(1).authentication
    end
    
    it "should change users" do
      one = Factory(:user, authentications: [{ provider: 'fake', uid: 'andy' }])
      two = Factory(:user, authentications: [{ provider: 'fake', uid: 'john' }])
      session[:session_token] = one.session_token
      
      get :create, provider: 'fake'
      
      one.reload.should have(1).authentication
      two.reload.should have(1).authentication
      
      assigns(:user).should == two
      session[:session_token].should == two.session_token
    end
    
    it "should add authentication to user" do
      user = Factory(:user, authentications: [{provider: 'fake', uid: 'andy'}])
      session[:session_token] = user.session_token
      
      get :create, provider: 'fake'
      
      auth = assigns(:auth)
      user.reload.should have(2).authentication
      user.authentications.should include(auth)
      auth.provider.should     == 'fake'
      auth.uid.should          == 'john'
      auth.used_at.utc.should  == @time_now
      
      flash[:notice].should include("john on fake was linked to #{user.login}")
    end
    
    it "should not signin user without e-mail" do
      @fake['user_info']['email'] = nil
      
      get :create, provider: 'fake'
      
      session[:session_token].should be_nil
      flash[:notice].should be_nil
      flash[:error].should include('provide e-mail')
    end
    
    it "should not signin user with occupied e-mail" do
      user = Factory(:user, authentications: [{provider: 'fake', uid: 'andy'}])
      @fake['user_info']['email'] = user.email
      
      get :create, provider: 'fake'
      
      session[:session_token].should be_nil
      flash[:notice].should be_nil
      flash[:error].should include('is already occupied')
      flash[:error].should include('/auth/fake')
    end
  
  end
  
  describe "#failure" do
    
    it "should show flash on failure" do
      get :failure, message: 'invalid_response'
      response.should redirect_to(root_url)
      flash[:error].should include('invalid response')
    end
    
  end
  
  describe "#destroy" do
  
    it "should logout user" do
      user = Factory(:user)
      session[:session_token] = user.session_token
      
      post :destroy
      
      response.should redirect_to(root_url)
      session[:session_token].should be_nil
    end
  
  end
  
end
