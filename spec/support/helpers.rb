require 'support/helpers/sessions_helper'
RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
end
