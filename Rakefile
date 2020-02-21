require "rake"

# Define testing rake process
begin
    require "rspec/core/rake_task"

    RSpec::Core::RakeTask.new(:spec) do |rake_task|
        rake_task.rspec_opts = "-fd"
    end
    
    task :test => :spec
rescue LoadError
    puts "No RSpec available!"
end