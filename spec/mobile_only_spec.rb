require 'spec_helper'
require 'pages/fake_page'

describe FakePage do
  Given(:browser) { mock_browser }

  shared_examples "a mobile-only element" do
    Then { expect{page.only_link}.to raise_error }
    And { page.should.respond_to?(:mobile_only_link) }
  end

  context "normal page object" do
    Given(:page) { FakePage.new(browser) }
    it_behaves_like "a mobile-only element"
  end

  context "mobilified page object" do
    Given(:page) { FakePage.new(browser, :agent => :mobile) }
    it_behaves_like "a mobile-only element"
  end

end
