module Salesforce
  #
  # The following fields are given by Heroku connect
  # 
  # id: integer
  # - A unique, auto-incrementing integer primary key
  # 
  # sfid: varchar(18)
  # - The Salesforce object Id field that is automatically populated when
  #   records are synchronized with Salesforce and is indexed
  #   (with a unique constraint) for better query performance
  # 
  # systemmodstamp: timestamp
  # - The date and time (in the UTC time zone) that
  #   the Salesforce object was last modified and used by Heroku Connect when
  #   polling for updates
  # 
  # isdeleted: boolean
  # - Used to track the IsDeleted field from Salesforce allowing
  #   Heroku Connect to handle deletes when polling for updates.
  # 
  # _hc_lastop: varchar(32)
  # - Indicates the last sync operation performed on the record.
  # 
  # _hc_err:varchar(1024)
  # - If the last sync operation resulted in an error then this column will
  #   contain a JSON object containing more information about the error.
  #
  class SObject < ActiveRecord::Base

    self.abstract_class = true

    def self.resolve_table_name(custom_object: false)
      table_name = self.name.demodulize.underscore
      # objects might be custom in which case Salesforce appends __c to
      # the table name.
      if custom_object
        table_name << "__c"
      end
      # heroku connect stores it's objects under a dedicated schema.
      schema = ENV.fetch('HEROKUCONNECT_SCHEMA')
      # heroku connect table is the schema and table name.
      self.table_name = "#{schema}.#{table_name}"
    end

    def self.find_connection
      if Rails.env.production? || Rails.env.uat?
        ENV.fetch('HEROKUCONNECT_URL')
      else
        configurations.fetch("#{Rails.env}_heroku_connect")
      end
    end

    establish_connection find_connection

  end
end
