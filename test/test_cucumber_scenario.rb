require 'minitest/autorun'
require 'cucumber-snapshot/cucumber_scenario'

include CucumberSnapshot

class CucumberScenarioTest < MiniTest::Unit::TestCase  
  def setup
    @sexp = [:scenario,
            33,
            "Scenario",
            "Scenar Title",
            [:tag, "@tag1"], [:tag, "@snap_capture"], [:tag, "@snap_compare"],
            [:step_invocation, 34, "Given ", "I am logged with email \"john@doe.com\""],
            [:step_invocation, 35, "When ", "I go to the home page"],
            [:step_invocation, 36, "Then ", "I should see \"HOME\""]
            ]
  	@scenar = CucumberScenario.new @sexp
  end

  def test_steps
    assert_equal @scenar.steps, [[:step_invocation, 34, "Given ", "I am logged with email \"john@doe.com\""],
                                    [:step_invocation, 35, "When ", "I go to the home page"],
                                    [:step_invocation, 36, "Then ", "I should see \"HOME\""]]
  end

  def test_when_steps
    assert_equal @scenar.when_steps,          [[:step_invocation, 35, "When ", "I go to the home page"]]
  end

  def test_when_steps_given_2_when_steps
    sexp_copy = Array.new @sexp
    @two_when_scenar = CucumberScenario.new(sexp_copy << [:step_invocation, 37, "When ", "I go to the members page"] << [:step_invocation, 38, "Then ", "I should see \"MEMBERS\""])
    
    assert_equal @two_when_scenar.when_steps, [[:step_invocation, 35, "When ", "I go to the home page"],
                                               [:step_invocation, 37, "When ", "I go to the members page"]]
    assert_equal @two_when_scenar.when_step,  [:step_invocation, 35, "When ", "I go to the home page"]
  end

  def test_tags
    assert_equal  @scenar.tags, ["@tag1", "@snap_capture", "@snap_compare"]
  end

  def test_step_text
    assert_equal CucumberScenario.step_text([:step_invocation, 35, "When ", "I go to the home page"]), "I_go_to_the_home_page" 
  end


  def test_step_type
    assert_equal CucumberScenario.step_type([:step_invocation, 35, "When ", "I go to the home page"]), "When" 
  end

  def test_tagged_with?
    assert @scenar.tagged_with? "@snap_capture"
    refute @scenar.tagged_with? "@tag_inexistant"
  end

  def test_step_type_at
    assert_equal @scenar.step_type_at(1), "When"
    assert_nil @scenar.step_type_at(3)
    assert_nil @scenar.step_type_at(4)
  end

  def test_step_is_last
    assert @scenar.step_is_last(2)
    refute @scenar.step_is_last(0)
    refute @scenar.step_is_last(4)
  end

  def test_text
    assert_equal @scenar.text, "Scenar_Title"
    refute_equal @scenar.text, "My_Wrong_Title"
  end

end