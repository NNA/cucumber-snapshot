Given /^I create "([^"]*)" rails app requiring "([^"]*)" gems$/ do |rails_app_name, gem_list|
  gems = gem_list.split(',').map {|gem| gem.strip }
  Given "a directory named \"containing_folder\""
  append_to_file("containing_folder/Gemfile", gems.map {|gem_name| "gem #{gem_name} \n"}.join)
  When "I cd to \"containing_folder\""
  When "I run `rails new #{rails_app_name}`"
  When "I run `bundle install --verbose`"
  When "I cd to \"#{rails_app_name}\""
  gems.each do |gem_name|
  	Then "the output should contain \"Installing #{gem_name} (\""
  end
end