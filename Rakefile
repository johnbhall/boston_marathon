require 'bundler'
include Rake::DSL
Bundler::GemHelper.install_tasks

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc "Run tests"
task :default => :test