require 'support/helpers/sessions_helper'

RSpec.configure do |config|
  config.include Features::SessionsHelper, type: :feature
end
