require 'mobilify'

class FakePage
  include Mobilify

  link(:mobile_only_link, :href => "http://not-a-valid-link.com")

end
