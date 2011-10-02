Given /^I take a snapshot of the current page and save it as "([^"]*)"$/ do |picture_name|
  Snapshot.capture page, picture_name
end

Given /^I take a snapshot$/ do
  Snapshot.capture page
end

And /^I switch to (chrome|firefox) browser$/ do |browser|
  Capybara.current_driver = case browser
  when 'chrome' then :selenium_chrome
  when 'firefox' then :selenium
  else
    throw "ERROR"
  end
end

Then /^there is a snapshot called "([^"]*)"$/ do |snapshot_name|
  assert Snapshot.exists?(snapshot_name), "SNAPSHOT: The file could not be found in snapshot directory"
end