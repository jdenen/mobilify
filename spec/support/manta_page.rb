require 'mobilify'

class MantaPage
  include Mobilify

  page_url "http://www.manta.com/c/mm2fqg7"

  link(:to_map, :id => "map-tab-link")
  link(:mobile_to_map, :class => "pvm prm")

end
