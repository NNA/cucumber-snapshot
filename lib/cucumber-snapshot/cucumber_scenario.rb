module CucumberSnapshot
	class Scenario
		attr_accessor :sexp

		def initialize(s_exp)
			@sexp = s_exp
		end

		def steps
			@sexp.dup.delete_if{|x| x.class.to_s != 'Array' || x[0].to_s != 'step_invocation'}
		end

		def when_steps
			self.steps.keep_if{|element| element[2].strip == 'When'}
		end

		def when_step
			when_steps.first # refactor user step_type
		end

		def tags
			@sexp.select{|x| x.class.to_s=='Array' && x[0].to_sym == :tag}.map{|e|e[1]}
		end

		def step_text step_array
			step_array[3].gsub(' ','_')
		end

		def step_type step_array
			step_array[2].strip
		end

		def tagged_with? tag
			tags.include? tag
		end

		def step_type_at position
			# puts "steps_type_at #{position} #{step_type(steps[position])}"
			step_type(steps[position])
		end
		
		def step_is_last position
			# puts "this is the #{position} / #{steps.count-1} step"
			position == steps.count-1
		end

		def text
			@sexp[3].gsub(' ','_')
		end
	end
end