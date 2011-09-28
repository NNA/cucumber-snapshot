@snapshot
Feature: Snapshot
  In order improve design quality
  As web designer 
  I want to check that there is no regression in the design

@snap_capture @snap_compare
Scenario: Profile capture with firefox
Given I switch to firefox browser
When I go to the home page
Then I should see "HOME"