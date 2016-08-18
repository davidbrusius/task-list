Capybara.add_selector(:icon) do
  css { |icon| "i.glyphicon-#{icon}" }
end
