# Mobilify
[![Gem Version](https://badge.fury.io/rb/mobilify.png)](http://badge.fury.io/rb/mobilify)

Invoke one page-object method name but execute different definitions of that method based on the page-object's context. 

We use it at [Manta](www.manta.com) to keep the number of test scripts low while testing against multiple versions of the same feature (legacy version, new desktop version, new mobile version, etc).

## Usage
To contextualize your page objects, ```include Mobilify``` in the page class. For each method requiring a contextual replacement, create an element (or method) definition with your context prepended to the original's name (like `mobile_` or `legacy_`).

```ruby
# method
text_field(:password, :id => "user-pw")
# replacement
text_field(:mobile_password, :id => "mobile-pw")
```

Mobilify will replace called methods with their contextual counterparts if two conditions are met. First, a hash with a key-value pair of `:context => :{your_context}` is passed to the page object constructor. And second, the page object responds to `{your_context}_method`.

```ruby
# constructor
my_page = Page.new(@browser, :context => :mobile)
```

Mobilify also supports multiple contexts per page-object instance, invoking the first applicable context it matches in a given array.

```ruby
# multiple context constructor
my_page = Page.new(@browser, :context => [:legacy, :mobile])
```

#### Example

I want to test a login page, but my there are basically three versions of the same page in some cycle of development. There's legacy code, new responsive code at the desktop size, and new responsive code at the mobile size. All three have different identifiers for the login form.

I'll use Mobilify to write one script and test all browsers and environments.

```ruby
# login.rb
require "mobilify"

class Login
  include Mobilify
  
  text_field(:user, :id => "email")
  text_field(:mobile_user, :id => "xs-email")
  text_field(:legacy_user, :id => "member-email")
  
  text_field(:password, :id => "password")
  text_field(:mobile_password, :id => "xs-password")
  text_field(:legacy_password, :id => "member-password")
  
  button(:submit, :id => "submit")
end
```

```ruby
# login_spec.rb
require "rspec-given"
require "support/login"

describe "logging in" do
  Given(:login) { Login.new(@browser, :context => [:mobile, :legacy]) }
  When { login.goto }
  When { login.user = "member@example.com" }
  When { login.password = "password123" }
  When { login.submit }
  Then { ... }
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
