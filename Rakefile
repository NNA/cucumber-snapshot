require 'bundler'
require 'rake/testtask'

include Rake::DSL

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

Bundler::GemHelper.install_tasks