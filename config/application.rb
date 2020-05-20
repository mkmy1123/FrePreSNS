require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FrePreSNS
  class Application < Rails::Application
    config.load_defaults 5.2
    config.generators.template_engine = :slim
    config.time_zone = 'Tokyo'
    Time::DATE_FORMATS[:datetime_jp] = '%Y/%m/%d %H:%M:%S'
    Time::DATE_FORMATS[:date_jp] = '%Y/%m/%d'
    Time::DATE_FORMATS[:dateweek_jp] = '%Y/%m/%d %a %H:%M'
  end
end
