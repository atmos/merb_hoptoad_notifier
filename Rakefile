require 'rubygems'
require 'rake/gempackagetask'
require 'rubygems/specification'
require 'date'
require 'merb-core/version'
require 'spec/rake/spectask'
require 'bundler'

install_home = ENV['GEM_HOME'] ? "-i #{ENV['GEM_HOME']}" : ""

NAME = "merb_hoptoad_notifier"
GEM_VERSION = "1.0.10"
AUTHOR = "Corey Donohoe"
EMAIL = 'atmos@atmos.org'
HOMEPAGE = "http://github.com/atmos/merb_hoptoad_notifier"
SUMMARY = "Merb plugin that provides hoptoad exception notification"

spec = Gem::Specification.new do |s|
  s.rubyforge_project = 'merb'
  s.name = NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", 'TODO']
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE

  manifest = Bundler::Environment.load(File.dirname(__FILE__) + '/Gemfile')
  manifest.dependencies.each do |d|
    next unless d.only && d.only.include?('release')
    s.add_dependency(d.name, d.version)
  end

  s.require_path = 'lib'
  s.files = %w(LICENSE README Rakefile TODO) + Dir.glob("{lib,spec}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "create a gemspec file"
task :make_spec do
  File.open("#{NAME}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

Spec::Rake::SpecTask.new(:default) do |t|
  t.spec_opts << %w(-fs --color) << %w(-O spec/spec.opts)
  t.spec_opts << '--loadby' << 'random'
  t.spec_files = Dir["spec/*_spec.rb"]
  t.rcov = ENV.has_key?('NO_RCOV') ? ENV['NO_RCOV'] != 'true' : true
  t.rcov_opts << '--exclude' << '.gem/'

  t.rcov_opts << '--text-summary'
  t.rcov_opts << '--sort' << 'coverage' << '--sort-reverse'
  t.rcov_opts << '--only-uncovered'
end
