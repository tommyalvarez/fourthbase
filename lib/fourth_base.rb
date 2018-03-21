require 'rails'
require 'active_record'
require 'active_record/railtie'
require 'fourth_base/version'
require 'fourth_base/railtie'
require 'fourth_base/on_base'
require 'fourth_base/forced'

module FourthBase

  extend ActiveSupport::Autoload

  autoload :Base

  def self.config(env = nil)
    config = Rails.application.config.database_configuration[Railtie.config_key]
    config ? config[env || Rails.env] : nil
  end

end
