require 'page-object'

module Mobilify
  include PageObject

  def initialize(browser, opts = {})
    super(browser, opts[:visit] || false)
    @mobile = opts[:agent] == :mobile
    mobilify! if mobile?
  end

  def self.included(klass)
    klass.send :include, PageObject
  end

  def mobile?
    @mobile
  end

  private

  def mobilify!
    methods.
      select { |m| m.to_s.start_with? 'mobile_' }.
      select { |m| respond_to? m.to_s.gsub('mobile_', '') }.
      map { |m| self.method(m) }.each do |method|
        (class << self; self; end).class_eval do
          define_method(method.name.to_s.gsub('mobile_', ''), method)
        end
      end
  end

end


require 'mobilify/version'
