Bundler.setup(:default, :test)
$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require 'rr'
require 'merb-core'
require 'merb_hoptoad_notifier'
require 'tmpdir'
require 'pp'

class TestError < RuntimeError
end

Spec::Runner.configure do |config|
  config.mock_with :rr
  def fake_request
    Merb::Test::RequestHelper::FakeRequest.new
  end
  def fake_request_with_exceptions(params = { :controller => 'Application', :action => 'index' })
    request = Merb::Test::RequestHelper::FakeRequest.new(:params => params)
    begin
      raise(TestError, 'I like turtles')
    rescue => e
      request.exceptions = [ e ]
    end
    request
  end
end
