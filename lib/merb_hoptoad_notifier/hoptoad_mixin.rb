require File.expand_path(File.dirname(__FILE__)+'/hoptoad_notifier')

module HoptoadMixin
  def notify_hoptoad(request=nil, session=nil)
    request ||= self.request
    session ||= self.session
    
    HoptoadNotifier.notify_hoptoad(request, session)
  end
  
  def warn_hoptoad(message, request=nil, session=nil, options={})
    request ||= self.request
    session ||= self.session
    
    HoptoadNotifier.warn_hoptoad(message, request, session, options)
  end
end
