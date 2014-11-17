require 'mobilify'

class Page
  include Mobilify

  link(:login, class: "log-in-link ellipsis highlight")
  link(:desktop_login, class: "log-in-link ellipsis highlight")
  link(:mobile_login, class: "simple-button big-button")

  button(:other_button, class: "other-button-class")
end

