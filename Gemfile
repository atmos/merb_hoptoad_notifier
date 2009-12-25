bundle_path "vendor"
disable_system_gems

merb_gem_version = '>=1.0.7'

only :release do
  gem "merb-core",              merb_gem_version
  gem 'toadhopper',  '~>0.9.1'
end

only :test do
  gem 'rake'
  gem 'rcov'
  gem 'rr'
  gem 'ruby-debug'
  gem 'bundler',     '~>0.7.2'
end
