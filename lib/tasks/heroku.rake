require 'tempfile'

namespace :heroku do

  # Aquire the Heroku connect DB url for the given application.
  def heroku_connect_db_url(app_name)
    puts "Fetching Heroku connect db_url from app: #{app_name}".yellow
    Bundler.with_clean_env do
      result = `heroku config:get DATABASE_URL --app #{app_name}`.chomp
      if 0 == $?.exitstatus
        puts "Succeeded in fetching db_url for app: #{app_name}".green
        result
      else
        puts "Failed to fetch db_url for app: #{app_name}".red
        puts "Error: #{result}".red
        raise StandardError.new(result)
      end
    end
  end

  # Drop the local database of a give name.
  def psql_drop_db(db_name)
    result = `dropdb #{db_name}`
    if 0 == $?.exitstatus
      puts "Succeeded in dropping: #{db_name}".green
      result
    else
      puts "Failed to drop: #{db_name}".red
      puts "Error: #{result}".red
    end
    # Either way we want to create the db
    `createdb #{db_name}`
  end

  # Export the schema or the data from the given url.
  def psql_export(db_url)
    puts "Starting export of: #{db_url}".yellow
    temp_schema = Tempfile.new('temp_schema')
    puts "Dumping to #{temp_schema.path}"
    result = `pg_dump #{db_url} > #{temp_schema.path}`
    if 0 == $?.exitstatus
      puts "Succeeded in exporting: #{db_url}".green
      temp_schema.path
    else
      puts "Failed to export: #{db_url}".red
      puts "Error: #{result}".red
      raise StandardError.new(result)
    end
  end

  # Import the given data into the local database with the given name.
  def psql_import(db_name, import_data_path) 
    puts "Starting import into: #{db_name}".yellow
    result = `psql #{db_name} < #{import_data_path}`
    if 0 == $?.exitstatus
      puts "Succeeded in import into: #{db_name}".green
      result
    else
      puts "Failed to import into: #{db_name}".red
      puts "ERROR: #{result}".red
      raise StandardError.new(result)
    end
  end

  desc 'Sync a local instance of the Heroku connect db for dev and test.'
  task sync: :environment do |_t, _args|
    begin
      app_name = ENV.fetch('HEROKU_DEVELOPMENT_APP_NAME')
      app_heroku_connect_url = ENV['HEROKU_DEVELOPMENT_CONNECT_URL']
      if app_heroku_connect_url.blank?
        app_heroku_connect_url = heroku_connect_db_url(app_name)
      end
      export_file_path = psql_export(app_heroku_connect_url)
      %w( development test ).each do |environment|
        unless environment == "development" && Rails.env.test?
          local_app_name = Rails.application.config.session_options[:key].sub(/^_/,'').sub(/_session/,'')
          db_name = "#{local_app_name}_heroku_connect_#{environment}"
          psql_drop_db(db_name)
          psql_import(db_name, export_file_path)
        end
      end
    rescue StandardError => e
      puts "Syncronisation failed".red
      raise
    end
  end

end
