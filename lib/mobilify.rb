require 'mobilify/version'
require 'page-object'

module Mobilify
  include PageObject

  #
  # Build page object with context(s) for method replacement
  #
  def initialize(browser, opts = {})
    super(browser, opts[:visit] || false)
    @context = set_context opts[:context]
    mobilify! if @context
  end

  #
  # Returns context(s) passed to page object instance construction
  #
  # @return [Array]
  #
  def context
    @context
  end
  alias :context? :context

  private

  #
  # Include page-object too
  #
  def self.included klass
    klass.send :include, PageObject
  end

  #
  # Format given context(s) to Mobilify's liking
  #
  def set_context config
    return nil if config.nil?
    config.kind_of?(Array) ? config.flatten.map(&:to_sym) : [config].map(&:to_sym)
  end

  #
  # Iterate over contexts for method replacement
  #
  def mobilify!
    @context.each_with_object([]) do |c, array|
      next unless array.flatten.empty?
      array << match_and_replace(c.to_s)
    end
  end

  #
  # Method replacement
  #
  def match_and_replace context
    get_contextual_match(context).map { |m| self.method(m) }.each do |method|
      replace! method, context
    end
  end

  #
  # Find page object methods matching the given context
  #
  def get_contextual_match context
    methods.select{ |m| m.to_s.start_with? "#{context}_" }.select{ |m| respond_to? m.to_s.gsub("#{context}_","") }
  end

  #
  # Redefine contextually matching method as original method
  #
  def replace! method, context
    (class << self; self; end).class_eval{ define_method(method.name.to_s.gsub("#{context}_",""), method) }
  end
  
end
