require 'mobilify'

class MantaPage
  include Mobilify

  page_url "http://www.manta.com/c/mm2fqg7"

  link(:map, :xpath => "//div[@class='panel-body']//a[contains(@href, '/cmap/')]")
  link(:mobile_map, :xpath => "//div[@class='col-xs-6']/a[contains(@href, '/cmap/')]")
end
