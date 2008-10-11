require File.expand_path(File.dirname(__FILE__)+'/merb_hoptoad_notifier/hoptoad_notifier')

# make sure we're running inside Merb
if defined?(Merb::Plugins)

  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:merb_hoptoad_notifier] = {
    :api_key => ''
  }
  
  Merb::BootLoader.before_app_loads do
    # require code that must be loaded before the application
  end
  
  Merb::BootLoader.after_app_loads do
    HoptoadNotifier.configure do |config|
      config.api_key = Merb::Plugins.config[:merb_hoptoad_notifier][:api_key]
    end
    
    # code that can be required after the application loads
  end
  
  Merb::Plugins.add_rakefiles "merb_hoptoad_notifier/merbtasks"
end