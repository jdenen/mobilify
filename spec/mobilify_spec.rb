require 'rspec'
require 'support/page'

describe Mobilify do
  before :all do
    @browser = Watir::Browser.new
    @mobilify = ->(context = nil){ Page.new @browser, context: context }
  end
  
  it "includes PageObject" do
    expect(Page.included_modules[1]).to eq PageObject
  end

  context "when given no context" do
    it "does not perform method replacement" do
      page = @mobilify.call
      expect(page.login_element.inspect).to include("log-in-link ellipsis highlight")
    end
  end

  context "when given a single context" do
    it "does not perform method replacement for an invalid context" do
      page = @mobilify.call 'wrong'
      expect(page.login_element.inspect).to include("log-in-link ellipsis highlight")
    end

    it "does not perform method replacement without an original method" do
      page = @mobilify.call 'other'
      expect(page.other_button_element.inspect).to include("other-button-class")
    end

    it "does not perform method replacement without the correct context" do
      page = @mobilify.call 'mobile'
      expect(page.other_button_element.inspect).to include("other-button-class")
    end

    it "performs method replacement for a valid context" do
      page = @mobilify.call 'mobile'
      expect(page.login_element.inspect).to include("simple-button big-button")
    end
  end

  context "when given multiple contexts" do
    it "does not perform method replacement for invalid contexts" do
      page = @mobilify.call ['no_match', 'wrong']
      expect(page.login_element.inspect).to include("log-in-link ellipsis highlight")
    end

    context "and the first context matches" do
      it "performs method replacement with the first matching context" do
        page = @mobilify.call ['mobile', 'wrong']
        expect(page.login_element.inspect).to include("simple-button big-button")        
      end

      it "does not perform method replacement with the second matching context" do
        page = @mobilify.call ['mobile', 'desktop']
        expect(page.login_element.inspect).to include("simple-button big-button")                
      end
    end

    context "and the second context matches" do
      it "performs method replacement with the second context" do
        page = @mobilify.call ['wrong', 'mobile']
        expect(page.login_element.inspect).to include("simple-button big-button")                
      end
    end

    context "and the first and last contexts match" do
      it "performs method replacement with the first matching context" do
        page = @mobilify.call ['mobile', 'wrong', 'ignore', 'nothing', 'desktop']
        expect(page.login_element.inspect).to include("simple-button big-button")
      end
    end
  end

  describe "#initialize" do
    context "without context" do
      it "returns the page object instance" do
        expect(@mobilify.call).to be_a Page
      end
    end
    
    context "with context" do
      it "returns the page object instance" do
        expect(@mobilify.call 'mobile').to be_a Page
      end
    end
  end

  describe "#context" do
    it "returns nil when for context" do
      page = @mobilify.call
      expect(page.context).to be_nil
    end

    it "returns an array for one context" do
      page = @mobilify.call 'desktop'
      expect(page.context).to eq [:desktop]
    end

    it "returns an array for multiple contexts" do
      page = @mobilify.call ['one', 'two', 'three']
      expect(page.context).to eq [:one, :two, :three]
    end

    it "can be called as #context?" do
      page = @mobilify.call 'desktop'
      expect(page.context?).to eq [:desktop]
    end
  end

  describe "#set_context" do
    let(:page){ @mobilify.call }
    
    it "returns nil when given nil" do
      expect(page.send :set_context, nil).to be_nil
    end

    context "when given a single context" do
      it "converts context into an array" do
        expect(page.send :set_context, :one).to eq [:one]
      end

      it "converts strings to symbols" do
        expect(page.send :set_context, "one").to eq [:one]
      end

      it "flattens a single-element array" do
        expect(page.send :set_context, [:one]).to eq [:one]
      end
    end

    context "when given multiple contexts" do
      it "converts strings to symbols" do
        expect(page.send :set_context, ["one", "two"]).to eq [:one, :two]
      end

      it "flattens multiple arrays" do
        expect(page.send :set_context, [[:one, :two], [:three, :four]]).to eq [:one, :two, :three, :four]
      end
    end
  end

  describe "#get_contextual_match" do
    let(:page){ @mobilify.call }
    
    it "returns an array" do
      expect(page.send :get_contextual_match, "one").to be_an Array
    end

    it "returns an empty array with invalid context" do
      expect(page.send :get_contextual_match, "one").to be_empty
    end

    it "returns three-item array with valid context" do
      expect(page.send(:get_contextual_match, "mobile").size).to eq 3
    end
  end
end
