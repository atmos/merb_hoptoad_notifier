require File.dirname(__FILE__) + '/spec_helper'

describe "HoptoadNotifier" do
  before(:each) do
    config = { :development => { :api_key=> ENV['MY_HOPTOAD_API_KEY'] || 'blah' } }
    mock(YAML).load_file(File.join(Merb.root / 'config' / 'hoptoad.yml')) { config }

    Merb::HoptoadNotifier.configure
  end
  describe "notification" do
    it "posts to hoptoad" do
      Merb::HoptoadNotifier.notify_hoptoad(fake_request_with_exceptions, { :user_id => 42 })
    end
  end
end
