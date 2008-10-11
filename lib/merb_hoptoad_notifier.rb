require 'merb-core'
require File.expand_path(File.dirname(__FILE__)+'/merb_hoptoad_notifier/hoptoad_notifier')

# make sure we're running inside Merb
if defined?(Merb::Plugins)

  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  
  Merb::BootLoader.after_app_loads do
    HoptoadNotifier.configure
    # code that can be required after the application loads
  end
  
  Merb::Plugins.add_rakefiles "merb_hoptoad_notifier/merbtasks"
end