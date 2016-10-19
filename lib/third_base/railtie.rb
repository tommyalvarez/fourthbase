module ThirdBase
  class Railtie < Rails::Railtie

    config.third_base = ActiveSupport::OrderedOptions.new
    config.third_base.path = 'db/secondbase'
    config.third_base.config_key = 'secondbase'
    config.third_base.run_with_db_tasks = true

    config.after_initialize do |app|
      secondbase_dir = app.root.join(config.third_base.path)
      FileUtils.mkdir(secondbase_dir) unless File.directory?(secondbase_dir)
    end

    rake_tasks do
      load 'third_base/databases.rake'
      
      if Rails.version.to_i == 4
        load 'third_base/databases_rails_four.rake'
      else
        load 'third_base/databases_rails_five.rake'
      end

    end

    generators do
      require 'rails/third_base/generators/migration_generator'
    end

    initializer 'third_base.add_watchable_files' do |app|
      secondbase_dir = app.root.join(config.third_base.path)
      config.watchable_files.concat ["#{secondbase_dir}/schema.rb", "#{secondbase_dir}/structure.sql"]
    end

    def config_path
      config.third_base.path
    end

    def config_key
      config.third_base.config_key
    end

    def run_with_db_tasks?
      config.third_base.run_with_db_tasks
    end

    def fullpath(extra=nil)
      path = Rails.root.join(config.third_base.path)
      (extra ? path.join(path, extra) : path).to_s
    end

  end
end
