require "./lib/mobilify"

class KhanAcademy
  include Mobilify

  page_url "http://www.khanacademy.org"

  link(:login, :class => "log-in-link ellipsis highlight")
  link(:mobile_login, :class => "simple-button big-button")
  link(:ignored_login, :class => "simple-button primary big-button")
end

