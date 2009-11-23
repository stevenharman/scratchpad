require 'rake'
require 'rake_example_helpers'

desc "using the +task+ convience method, executes block as expected"
task :task_method => [:release_mode, :print_info]

desc "using a custom task, executes block too early (when task newed up)"
task :new_unexpected => [:release_mode, :unexpected]

desc "using a custom task, executes block as expected (just before doing its work)"
task :new_expected => [:release_mode, :expected]



task :print_info do
  puts "task running in #{@options[:mode]} mode"
end

Example::UnexpectedTask.new(:unexpected) do |task|
  task.config_value = @options[:mode]
end

Example::ExpectedTask.new(:expected) do |task|
  task.config_value = @options[:mode]
end

task :release_mode do
  @options[:mode] = :release
end

