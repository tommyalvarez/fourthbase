namespace :db do
  namespace :fourth_base do
    task "drop:_unsafe" do
      FourthBase.on_base { Rake::Task['db:drop:_unsafe'].execute }
    end

    namespace :migrate do
      task :reset => ['db:fourth_base:drop:_unsafe', 'db:fourth_base:create', 'db:fourth_base:migrate']
    end
  end
end

%w{
  drop:_unsafe
}.each do |name|
  task = Rake::Task["db:#{name}"] rescue nil
  next unless task && FourthBase::Railtie.run_with_db_tasks?
  task.enhance do
    Rake::Task["db:load_config"].invoke
    Rake::Task["db:fourth_base:#{name}"].invoke
  end
end
