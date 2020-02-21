require "rake"

begin
    require "rspec/core/rake_task"

    RSpec::Core::RakeTask.new(:spec) do |rake_task|
        rake_task.rspec_opts = "-fd"
    end
    
    task :test => :spec
rescue LoadError
    puts "No RSpec available!"
end

# task :test => :spec do
#     begin
#         require "rspec/core/rake_task"
#         RSpec::Core::RakeTask.new(:spec) do |rake_task|
#             rake_task.rspec_opts = "-fd"
#         end
#         Rake::Task["spec"].execute
#     rescue LoadError
#     end
# end