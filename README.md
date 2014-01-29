# Mobilify
[![Gem Version](https://badge.fury.io/rb/mobilify.png)](http://badge.fury.io/rb/mobilify)

Mobilify allows you to create one page object and write one test for your web application at different sizes. Just change context when initializing your object.

## Usage
To Mobilify your page objects, ```include Mobilify``` in the page class. For each method requiring a mobile replacement, create an element definition with ```mobile_``` prepended to the original's name.

```ruby
# method
text_field(:password, :id => "user-pw")
# replacement
text_field(:mobile_password, :id => "mobile-pw")
```

Mobilify will replace called methods with their ```mobile_``` counterparts if two conditions are met. First, a hash with a key-value pair of ```:agent => :mobile``` is passed to the page object constructor. And second, the page object responds to a ```mobile_``` version of the called method.

```ruby
# constructor
my_page = Page.new(@browser, :agent => :mobile)
```

To navigate to your page object during initialization, pass the key-value pair ```:visit => true``` to the constructor.
```ruby
# visiting
my_page = Page.new(@browser, :visit => true)
my_page = Page.new(@browser, :visit => true, :agent => :mobile)
```

#### Example

You're testing a responsive page with a link to your registration form. But you can only identify the link with XPath, and the XPath changes between your desktop-sized application and your mobile-sized application.

```ruby
# spec/page.rb
require 'mobilify'

class Page
  include Mobilify
  
  page_url "http://my-page.com"
  
  link(:to_registration, :xpath => '//xpath/to/desktop/register/link')
  link(:mobile_to_registration, :xpath => '//xpath/to/mobile/register/link')
end
```

```ruby 
# spec/spec_helper.rb
require 'watir-webdriver'
require 'webdriver-user-agent'

RSpec.configure do |config|
  
  config.before :all do
    case ENV['BROWSER']
    when 'desktop'
      @browser = Watir::Browser.new :firefox
      @agent = :desktop
    when 'mobile'
      driver = Webdriver::UserAgent.driver(:browser => :firefox, :agent => :iphone)
      @browser = Watir::Browser.new driver
      @agent = :mobile
    end
  end
end
```

```ruby
# spec/registration_link_spec.rb
require 'spec_helper'
require 'page'

describe Page do
  let(:page) { Page.new(@browser, :agent => @agent, :visit => true) }
  
  describe "#to_registration" do
    it "takes me to the registration form" do
      page.to_registration
      @browser.url.should == "http://my-page.com/registration"
    end
  end
end
```

## Installation

Add this line to your application's Gemfile:

    gem 'mobilify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mobilify

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Questions, Comments, Concerns
Easiest place to reach me is Twitter, [@jpdenen](http://twitter.com/jpdenen)
