# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
    gem.name         = "email_spec"
    gem.platform     = Gem::Platform::RUBY
    gem.authors      = ['Ben Mabey', 'Aaron Gibralter', 'Mischa Fierer']
    gem.email        = "ben@benmabey.com"
    gem.homepage     = "http://github.com/bmabey/email-spec/"
    gem.summary      = "Easily test email in rspec and cucumber"
    gem.bindir       = "bin"
    gem.description  = gem.summary
    gem.require_path = "lib"
    gem.files        = %w(History.txt MIT-LICENSE.txt README.md Rakefile) + Dir["lib/**/*"] + Dir["rails_generators/**/*"]

    # rdoc
    gem.has_rdoc          = true
    gem.extra_rdoc_files  = %w(README.md MIT-LICENSE.txt History.txt)

    # dependencies defined in Gemfile
  end
  Jeweler::RubygemsDotOrgTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: <sudo> gem install jeweler"
end

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

task :default => [:features, :spec]

desc "Cleans the project of any tmp file that should not be included in the gemspec."
task :clean do
  #remove stuff from example rails apps
  FileUtils.rm_rf("examples/rails_root")
  FileUtils.rm_rf("examples/sinatra")
  %w[ rails3 sinatra ].each do |ver|
    FileUtils.rm_f("examples/#{ver}_root/features/step_definitions/email_steps.rb")
    FileUtils.rm_f("examples/#{ver}_root/rerun.txt")
    FileUtils.rm_rf("examples/#{ver}_root/log")
    FileUtils.rm_rf("examples/#{ver}_root/vendor")
  end

  %w[*.sqlite3 *.log #*#].each do |pattern|
    `find . -name "#{pattern}" -delete`
  end
end

desc "Cleans the dir and builds the gem"
task :prep => [:clean, :gemspec, :build]
