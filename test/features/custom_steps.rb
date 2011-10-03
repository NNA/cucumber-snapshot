When /^I do something$/ do
  puts Dir.pwd
end

Given /^I create "([^"]*)" rails app requiring "([^"]*)" gems$/ do |rails_app_name, gem_list|
  When "I run `rails new #{rails_app_name}`"
  puts "toto"+gem_list.split(',').each {|gem_name| puts "gem #{gem_name} \\n"}.join
  append_to_file("#{rails_app_name}/Gemfile", gem_list.split(',').each {|gem_name| puts "gem #{gem_name}"}.join)
 #  When "I append to \"#{rails_app_name}/Gemfile\" with:"
	# """
	# gem "cucumber-snapshot"
	# """
	When "I cd to \"#{rails_app_name}\""
	And "I run `bundle`"
	gem_list.split(',').each do |gem|
		puts "gem#{gem}"
    	Then "the output should contain \"#{gem}\""
    end
end