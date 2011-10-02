# Cucumber-Snapshot: Unchanged UX

The purpose of this tool is to make the design of the website doesn't change even after a tiny change in HTML / CSS / Javascript. Cucumber is great to test the Website behave in defined way. Great but not enough ! What if an unclose div completely breaks the layout of your homepage? Do you think it is well tested ? I don't.

## Install:
1) Install gem

``` ruby
gem install cucumber-snapshot
```

OR in your Gemfile (if using Bundler):

``` ruby
gem 'cucumber-snapshot', :git=>'https://github.com/NNA/cucumber-snapshot'
```

2) Create a file features/support/cucumber_snapshot.rb  with the following content:

``` ruby
  require 'cucumber-snapshot/cucumber_hooks'
```

3) Copy to your /feature folder and adapt the following files: 
 - examples/snapshot.feature
 - examples/cucumber-snapshot_steps.rb 

4) Run cucumber features:

``` bash
bundle exec cucumber -t @snapshot
```


## How To:

### Capturing Snapshots
cucumber-snapshot comes with some cucumber steps that you can use to take snapshots of your pages (see [examples]):

``` gherkin
  Given I am logged with email "john@doe.com"
  When I go to the home page
  And I take a snapshot #Will take a snapshot of current page
```

 or you can use the @snap_capture tag

``` gherkin
  @snap_capture #Will take a snapshot at the When page
  Given I am logged with email "john@doe.com"
  When I go to the home page 
```

snapshots are : 
 - full page screenshots as displayed using specified capybara driver (can be selenium or webrat)
 - saved as .png   
 - saved using this folder pattern : "app_root" \ snapshots \ "name_of_when_step"

### Comparing Snapshots
``` gherkin
  @snap_capture @snap_compare #Will take a snapshot of When page and compare. Will fail if differences are > 5%
  Given I am logged with email "john@doe.com"
  When I go to the home page
```

## Notes:
  - Do not change Scenario name otherwise the previous snapshot will not be used

## TODO
 - Feature Testing of app using cucumber-snapshot (should create snapshot, compare, etc...)
 - Remove warning: class variable access from toplevel
 - Save snapshots in Scenario subfolders so it becomes possible to have 2 When steps on differents scenarios.
 - Document how to change driver and improve existing steps
 - Cucumber Rake Tasks to automatically take snapshot of every When step without adding @snapshot or @compare tags
 - Reset Reference snapshots : maybe using a cucumber task
 - Use generators to automatically create folders, add examples files to the project so you don't have to add them manually
 - Take snapshots of certains parts of page using 2 x,y coordinates (usefull if some parts always change): 

 ``` gherkin
 	And I take a snapshot at (x,y) and (x,y) # Will take a snapshot of current page of the square calculated with 2 points
 ```

 - Add error threshold on snapshots: 

 ``` gherkin
 	@snap_capture @snap_compare_5 #Will take a snapshot at the When page. Will fail if differences are > 5%
  	Given I am logged with email "john@doe.com"
    When I go to the home page
 ```

 - Use Travis CI

 [examples]: https://github.com/NNA/cucumber-snapshot/tree/master/examples