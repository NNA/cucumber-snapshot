Feature: Gem Install
  In order to use the gem
  As a Gem user
  I want to be sure install of gem is working

  Scenario: Adding gem should work
	When I append to "example_app/Gemfile" with:
	"""
	gem "cucumber-snapshot"
	"""
	When I cd to "example_app"
	And I run `bundle`
    Then the output should contain "Installing cucumber-snapshot (0.0.2)"