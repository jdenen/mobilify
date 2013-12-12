require 'mobilify'

class MantaPage
  include Mobilify

  page_url "http://www.manta.com/c/mm2fqg7"

  link(:map, :id => "map-tab-link")
  link(:mobile_map, :class => "pvm prm")
end
