require 'rspec'
require 'rspec-given'
require 'watir-webdriver'
require 'webdriver-user-agent'

$:.unshift(File.dirname(File.expand_path('lib')))
$:.unshift(File.dirname(File.expand_path('spec/support')))

RSpec.configure do |config|

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run_excluding :skip => true
  config.color_enabled = true

end

def mock_browser
  browser = double('watir')
  browser.stub(:is_a?).with(anything()).and_return(false)
  browser.stub(:is_a?).with(Watir::Browser).and_return(true)
  browser
end
