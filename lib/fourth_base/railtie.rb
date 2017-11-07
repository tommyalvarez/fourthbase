module FourthBase
  class Railtie < Rails::Railtie

    config.fourth_base = ActiveSupport::OrderedOptions.new
    config.fourth_base.path = 'db/fourthbase'
    config.fourth_base.config_key = 'fourthbase'
    config.fourth_base.run_with_db_tasks = true

    config.after_initialize do |app|
      fourthbase_dir = app.root.join(config.fourth_base.path)
      FileUtils.mkdir(fourthbase_dir) unless File.directory?(fourthbase_dir)
    end

    rake_tasks do
      load 'fourth_base/databases.rake'
      
      if Rails.version.to_i == 4
        load 'fourth_base/databases_rails_four.rake'
      else
        load 'fourth_base/databases_rails_five.rake'
      end

    end

    generators do
      require 'rails/fourth_base/generators/migration_generator'
    end

    initializer 'fourth_base.add_watchable_files' do |app|
      fourthbase_dir = app.root.join(config.fourth_base.path)
      config.watchable_files.concat ["#{fourthbase_dir}/schema.rb", "#{fourthbase_dir}/structure.sql"]
    end

    def config_path
      config.fourth_base.path
    end

    def config_key
      config.fourth_base.config_key
    end

    def run_with_db_tasks?
      config.fourth_base.run_with_db_tasks
    end

    def fullpath(extra=nil)
      path = Rails.root.join(config.fourth_base.path)
      (extra ? path.join(path, extra) : path).to_s
    end

  end
end
