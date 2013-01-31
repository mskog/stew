require 'rake'
require "bundler/gem_tasks"
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'
require "rake/rdoctask"

Rake::RDocTask.new do |rd| 
 rd.rdoc_files.include("lib/**/*.rb")
 rd.rdoc_dir = "rdoc"
end


RSpec::Core::RakeTask.new(:spec)

task :default  => :spec
