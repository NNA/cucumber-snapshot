@snapshot
Feature: Snapshot
	In order improve design quality
	As web designer 
	I want to check that there is no regression in the design

Given the following users
     | user_name  | email            | first_name | last_name | post_code | gender | date_of_birth | city    | admin |
     | guyroux    | gr@ajauxerre.com | Guy        | Roux      | 75000     | M      | 1960-12-31    | auxerre | false |

@selenium_chrome
Scenario: Profile capture with chrome
  Given I am logged with email "gr@ajauxerre.com"
  And I switch to chrome browser
  When I go to the home page
  And I take a snapshot of the current page and save it as "screen_home_chrome"

@selenium_firefox
Scenario: Profile capture with firefox
  Given I am logged with email "gr@ajauxerre.com"
  And I switch to firefox browser
  When I go to the home page
  And I take a snapshot of the current page and save it as "screen_home_firefox"

@selenium_firefox @snap_capture
Scenario: Profile capture with firefox
Given I am logged with email "gr@ajauxerre.com"
And I switch to firefox browser
When I go to the home page
Then there is a snapshot called "I_go_to_the_home_page"

@selenium_firefox @snap_capture @snap_compare
Scenario: Profile capture with firefox
Given I am logged with email "gr@ajauxerre.com"
And I switch to firefox browser
When I go to the home page
Then I should see "HOME"

 #TODO @rack_test should work
# @rack_test @snap_capture
# Scenario: Profile capture with rack_test
# Given I am logged with email "gr@ajauxerre.com"
# When I go to the home page
# Then snapshot called "I_go_to_the_home_page" exist
Scenario: Compare file
  Given I have 2 files "screen_home_firefox_original" and "screen_home_firefox_copy"
  When I compare the 2 files
  Then I should see no differences
  
  # And I take a snapshot of the current page and save it as "screen_home_firefox"

  # Given I take a snapshot of "the home page" with "chrome" and "firefox" browsers
  # Then I should see no difference
  
  # 
  # Manual
  # 
  # Capturing Snapshots
  # 
  # Given I am logged with email "gr@ajauxerre.com"
  # When I go to the home page
  # And I take a snapshot #Will take a snapshot of current page
  # And I take a snapshot at (x,y) and (x,y) # Will take a snapshot of current page of the square calculated with x and y points
  # 
  # @snap_capture #Will take a snapshot at the When page use a Before Scenario to place a hook
  # Given I am logged with email "gr@ajauxerre.com"
  # When I go to the home page 
  #
  # Comparing Snapshots
  # Given I have previous snapshots
  # Then everything should be the same ~ 5% #Will compare every pages and fail if differerences are > 5%
  # 
  # @snap_capture @snap_compare #Will take a snapshot at the When page and compare the pages step. will fail if differences are > 5%
  # Given I am logged with email "gr@ajauxerre.com"
  # When I go to the home page
  # ....
  # Notes:
  # - Do not change Scenario name otherwise the previous snapshot will not be used
  # show me the change # displays the delta image enhancing the differences 



  # And I take a snapshot of the current page and save it as "screen_home_firefox"