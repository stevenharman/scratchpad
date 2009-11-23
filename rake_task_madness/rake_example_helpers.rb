require 'rake/tasklib'

class TaskRunner
  
  attr_accessor :config_value
  
  def initialize
		super()
	end
  
  def execute
    puts "task running in #{@config_value} mode"
  end
end

module Example
	class ExpectedTask < Rake::TaskLib
		attr_accessor :name
		
		def initialize(name=:etask, &block)
			@name = name
			@the_task = TaskRunner.new
			@block = block
			define
		end
		
		def define
			task name do
			  @block.call(@the_task) unless @block.nil?
				@the_task.execute
			end
		end		
	end
	
	class UnexpectedTask < Rake::TaskLib
		attr_accessor :name
		
		def initialize(name=:utask, &block)
			@name = name
			@the_task = TaskRunner.new
			yield @the_task if block_given?
			define
		end
		
		def define
			task name do
				@the_task.execute
			end
		end		
	end
end


def setup_defaults
  @options = {}
  
  @options[:mode] = "dev"
  @options[:version] = "0.0.1"
end

setup_defaults