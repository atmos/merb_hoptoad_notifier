if defined?(Merb::Plugins)
  libdir = File.join(File.dirname(__FILE__), 'merb_hoptoad_notifier')
  require 'toadhopper'
  require File.join(libdir, 'hoptoad_notifier')

  Merb::BootLoader.after_app_loads do
    HoptoadNotifier.configure
  end
end
