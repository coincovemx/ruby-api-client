
require 'bundler/gem_tasks'

begin
  require 'rspec/core'
  require 'rspec/core/rake_task'
  require File.expand_path('spec/spec_helper')

  RSpec::Core::RakeTask.new
  task default: :spec
  task test:    :spec

rescue LoadError
end

task :console do
  exec 'irb -r volabit -I ./lib'
end
