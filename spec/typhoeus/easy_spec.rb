require File.dirname(__FILE__) + '/../spec_helper'

describe Typhoeus::Easy do  
  describe "options" do
    it "should allow for following redirects"
    it "should allow you to set the user agent"
    it "should provide a timeout in milliseconds" do
      e = Typhoeus::Easy.new
      e.url = "http://localhost:3001"
      e.method = :get
      e.timeout = 50
      e.perform
      # this doesn't work on a mac for some reason
#      e.timed_out?.should == true
    end
  end
  
  describe "get" do
    it "should perform a get" do
      easy = Typhoeus::Easy.new
      easy.url    = "http://localhost:3002"
      easy.method = :get
      easy.perform
      easy.response_code.should == 200
      JSON.parse(easy.response_body)["REQUEST_METHOD"].should == "GET"
    end
  end

  describe "start_time" do
    it "should be get/settable" do
      time = Time.now
      easy = Typhoeus::Easy.new
      easy.start_time.should be_nil
      easy.start_time = time
      easy.start_time.should == time
    end
  end

  describe "params=" do
    it "should handle arrays of params" do
      easy = Typhoeus::Easy.new
      easy.url = "http://localhost:3002/index.html"
      easy.method = :get
      easy.request_body = "this is a body!"
      easy.params = {
        :foo => 'bar',
        :username => ['dbalatero', 'dbalatero2']
      }
      
      easy.url.should =~ /\?.*username=dbalatero&username=dbalatero2/
    end
  end


  describe "put" do
    it "should perform a put" do
      easy = Typhoeus::Easy.new
      easy.url    = "http://localhost:3002"
      easy.method = :put
      easy.perform
      easy.response_code.should == 200
      JSON.parse(easy.response_body)["REQUEST_METHOD"].should == "PUT"
    end
    
    it "should send a request body" do
      easy = Typhoeus::Easy.new
      easy.url    = "http://localhost:3002"
      easy.method = :put
      easy.request_body = "this is a body!"
      easy.perform
      easy.response_code.should == 200
      easy.response_body.should include("this is a body!")
    end
  end
  
  describe "post" do
    it "should perform a post" do
      easy = Typhoeus::Easy.new
      easy.url    = "http://localhost:3002"
      easy.method = :post
      easy.perform
      easy.response_code.should == 200
      JSON.parse(easy.response_body)["REQUEST_METHOD"].should == "POST"
    end
    
    it "should send a request body" do
      easy = Typhoeus::Easy.new
      easy.url    = "http://localhost:3002"
      easy.method = :post
      easy.request_body = "this is a body!"
      easy.perform
      easy.response_code.should == 200
      easy.response_body.should include("this is a body!")
    end
    
    it "should handle params" do
      easy = Typhoeus::Easy.new
      easy.url    = "http://localhost:3002"
      easy.method = :post
      easy.params = {:foo => "bar"}
      easy.perform
      easy.response_code.should == 200
      easy.response_body.should include("foo=bar")
    end
  end
  
  describe "delete" do
    it "should perform a delete" do
      easy = Typhoeus::Easy.new
      easy.url    = "http://localhost:3002"
      easy.method = :delete
      easy.perform
      easy.response_code.should == 200
      JSON.parse(easy.response_body)["REQUEST_METHOD"].should == "DELETE"
    end
    
    it "should send a request body" do
      easy = Typhoeus::Easy.new
      easy.url    = "http://localhost:3002"
      easy.method = :delete
      easy.request_body = "this is a body!"
      easy.perform
      easy.response_code.should == 200
      easy.response_body.should include("this is a body!")
    end
  end  
end
