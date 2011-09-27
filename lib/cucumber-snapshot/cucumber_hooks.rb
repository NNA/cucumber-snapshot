require 'cucumber-snapshot/cucumber_scenario'
require 'cucumber-snapshot/snapshot'

@@step_index = 0

Before('@snapshot') do
  @@step_index = 0
end

AfterStep('@snapshot') do |scenario|
	scenar = CucumberSnapshot::Scenario.new(scenario.to_sexp)
	# puts scenario.to_sexp
	if scenar.tagged_with?('@snap_capture') && scenar.step_type_at(@@step_index) == 'When'
		CucumberSnapshot::Snapshot.capture page, scenar.step_text(scenar.when_step)
	elsif scenar.tagged_with?('@snap_compare') && scenar.step_is_last(@@step_index)
    scenar.when_steps.each do |when_step|
      result = CucumberSnapshot::Snapshot.compare scenar.step_text(when_step)
      (assert false, "Snapshots do not match : diff is #{result[1]}") if result[1] > 0
    end
	end
  	@@step_index = @@step_index + 1
end

After do |scenario|
end