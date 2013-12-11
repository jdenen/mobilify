require 'spec_helper'
require 'pages/manta_page'

shared_examples "the map link" do
  Given { page_object.goto }
  When { page_object.to_map }
  Then { page_object.current_url.should include("/cmap/") }
end

describe MantaPage do

  after :each do
    browser.close
  end

  context "desktop user" do
    Given(:browser) { Watir::Browser.new :firefox }
    Given(:page_object) { MantaPage.new(browser) }

    it_behaves_like "the map link"
  end

  context "mobile user" do
    Given(:driver) { Webdriver::UserAgent.driver(:browser => :firefox, :agent => :iphone) }
    Given(:browser) { Watir::Browser.new driver }
    Given(:page_object) { MantaPage.new(browser, :agent => :mobile) }

    it_behaves_like "the map link"
  end

end
