$TESTING=true
$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require 'rr'
require 'merb_hoptoad_notifier'
require 'tmpdir'

Spec::Runner.configure do |config|
  config.mock_with :rr
end