require 'mobilify/version'
require 'page-object'

module Mobilify
  include PageObject

  def initialize(browser, opts = {})
    super(browser, opts[:visit] || false)
    @context = opts[:context]
    mobilify! if @context
  end

  def self.included(klass)
    klass.send :include, PageObject
  end

  def context?
    @context
  end

  def mobilify!
    match = false
    (contexts = []) << @context

    contexts.flatten.each do |c|
      next if match
      context = c.to_s
      methods.
        select { |m| m.to_s.start_with? "#{context}_" }.
        select { |m| respond_to? m.to_s.gsub("#{context}_", '') }.
        map { |m| self.method(m) }.each do |method|
          (class << self; self; end).class_eval do
            define_method(method.name.to_s.gsub("#{context}_", ''), method)
            match = true
          end
        end
    end
  end

end
