require "rake"

task :test => :spec do
    begin
        require "rspec/core/rake_task"
        RSpec::Core::RakeTask.new(:spec) do |rake_task|
            rake_task.rspec_opts = "-fd"
        end
        Rake::Task["spec"].execute
    rescue LoadError
    end
end