Feature: Gem Install
  In order to use the gem
  As a Gem user
  I want to be sure install of gem is working

  Scenario: Adding gem to Gemfile and using bundler should work
	When I run `rails new example_app`
	When I append to "example_app/Gemfile" with:
	"""
	gem "cucumber-snapshot"
	"""
	When I cd to "example_app"
	And I run `bundle`
    Then the output should contain "cucumber-snapshot (0.0.2)"

  @wip
  Scenario: Adding gem to Gemfile and using bundler should work
  	Given I create "example_app" rails app requiring "cucumber, cucumber-snapshot, capybara" gems