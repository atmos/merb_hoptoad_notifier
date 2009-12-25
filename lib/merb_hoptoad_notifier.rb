require 'toadhopper'
libdir = File.join(File.dirname(__FILE__), 'merb_hoptoad_notifier')
require File.join(libdir, 'hoptoad_notifier')

if defined?(Merb::BootLoader)
  Merb::BootLoader.after_app_loads do
    Merb::HoptoadNotifier.configure
  end
end
