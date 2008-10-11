require 'net/http'

module HoptoadNotifier
  class << self
    attr_accessor :api_key, :logger
    
    def configure
      key = YAML.load_file(Merb.root / 'config' / 'hoptoad.yml')
      @api_key = key[Merb.env][:api_key]
    end    
    
    def logger
      @logger || Merb.logger
    end
    
    def notify_hoptoad(request, session)
      params = request.params

      request.exceptions.each do |exception|
        data = {
          :api_key       => HoptoadNotifier.api_key,
          :error_class   => Extlib::Inflection.camelize(exception.class.name),
          :error_message => "#{Extlib::Inflection.camelize(exception.class.name)}: #{exception.message}",
          :backtrace     => exception.backtrace,
          :environment   => ENV.to_hash
        }
                    
        data[:request] = {
          :params => params[:original_params]
        }
 
        data[:environment].merge!(request.env)
        data[:environment][:RAILS_ENV] = Merb.env
       
        data[:session] = {
           :key         => session.instance_variable_get("@session_id"),
           :data        => session.instance_variable_get("@data")
        }
      
        send_to_hoptoad :notice => default_notice_options.merge(data)                 
      end
    end
    
    def send_to_hoptoad(data) #:nodoc:
      url = URI.parse("http://hoptoadapp.com:80/notices/")
      
      Net::HTTP.start(url.host, url.port) do |http|
        headers = {
          'Content-type' => 'application/x-yaml',
          'Accept' => 'text/xml, application/xml'
        }
        http.read_timeout = 5 # seconds
        http.open_timeout = 2 # seconds
        # http.use_ssl = HoptoadNotifier.secure
        response = begin
                     http.post(url.path, stringify_keys(data).to_yaml, headers)
                   rescue TimeoutError => e
                     logger.error "Timeout while contacting the Hoptoad server."
                     nil
                   end
        case response
        when Net::HTTPSuccess then
          logger.info "Hoptoad Success: #{response.class}"
        else
          # logger.error "Hoptoad Failure: #{response.class}"
          # 
          begin
            logger.error "Hoptoad Failure: #{response.class}\n#{response.body if response.respond_to? :body}"
          rescue => e
            puts e.backtrace
          end
            
          
        end
      end            
    end
    
    def default_notice_options #:nodoc:
      {
        :api_key       => HoptoadNotifier.api_key,
        :error_message => 'Notification',
        :backtrace     => caller,
        :request       => {},
        :session       => {},
        :environment   => ENV
      }
    end     
    
    def stringify_keys(hash) #:nodoc:
      hash.inject({}) do |h, pair|
        h[pair.first.to_s] = pair.last.is_a?(Hash) ? stringify_keys(pair.last) : pair.last
        h
      end
    end       
  end
end