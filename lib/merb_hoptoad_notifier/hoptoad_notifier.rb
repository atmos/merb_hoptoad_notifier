module Merb
  module HoptoadNotifier
    VERSION = '1.1.1'
    class << self
      attr_accessor :api_key, :logger, :environment_filters
    end

    def self.configure
      key = YAML.load_file(Merb.root / 'config' / 'hoptoad.yml')

      if key
        env = key[Merb.env.to_sym]
        env ? @api_key = env[:api_key] : raise(ArgumentError, "No hoptoad key for Merb environment #{Merb.env}")
      end
    end

    def self.environment_filters
      @environment_filters ||= [ ]
    end

    def self.environment_filters=(filters)
      environment_filters << filters
    end

    def self.logger
      @logger || Merb.logger
    end

    def self.notify_hoptoad(request, session)
      request.exceptions.each do |exception|
        options = {
          :api_key          => HoptoadNotifier.api_key,
          :url              => "#{request.protocol}://#{request.host}#{request.path}",
          :component        => request.params['controller'],
          :action           => request.params['action'],
          :request          => request,
          :framework_env    => Merb.env,
          :notifier_name    => 'Merb::HoptoadNotifier',
          :notifier_version => Merb::HoptoadNotifier::VERSION,
          :session          => session.to_hash
        }
        dispatcher.filters = environment_filters.flatten
        dispatcher.post!(exception, options, {'X-Hoptoad-Client-Name' => 'Merb::HoptoadNotifier'})
      end
      true
    end

    def self.dispatcher
      @dispatcher ||= ToadHopper.new(api_key)
    end
  end
end
