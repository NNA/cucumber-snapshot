# A sample Guardfile
# More info at https://github.com/guard/guard#readme
guard 'minitest', :colour => true, :drb => false do
  # with Minitest::Unit
  watch(%r|^test/test_(.*)\.rb|)
  watch(%r|^lib/(.*)([^/]+)\.rb|)     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r|^test/test_helper\.rb|)    { "test" }

  # with Minitest::Spec
  # watch(%r|^spec/(.*)_spec\.rb|)
  # watch(%r|^lib/(.*)\.rb|)            { |m| "spec/#{m[1]}_spec.rb" }
  # watch(%r|^spec/spec_helper\.rb|)    { "spec" }
end

guard 'spork' do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('spec/spec_helper.rb')
end
