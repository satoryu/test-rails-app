require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TestRailsApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    if ENV["RAILS_LOG_TO_STDOUT"].present?
      STDOUT.sync = true
      logger           = ActiveSupport::Logger.new(STDOUT)
      logger.formatter = config.log_formatter
      config.logger    = ActiveSupport::TaggedLogging.new(logger)
    end
  end
end
