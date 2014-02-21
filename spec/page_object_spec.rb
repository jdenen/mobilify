require 'spec_helper'

describe Mobilify do

  describe "includes PageObject when included" do
    Given { class Page; end }
    When { Page.send :include, Mobilify }
    Then { Page.included_modules[1].should == PageObject }
  end

end
