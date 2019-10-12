# frozen_string_literal: true

require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.setup

require 'ostruct'

# Feature Toggle library
module Schaltroom
  attr_accessor :calls

  @config ||= Config.new
  @repository ||= Repository.new
  @calls ||= []

  def self.add_feature(name, type, value)
   @repository.add_feature(name, type, value)
  end

  def self.config
    if block_given?
      yield @config
    else
      @config
    end
  end

  def self.repository
    if block_given?
      yield @repository
    else
      @repository
    end
  end

  def self.reset
    @config = Config.new
    @repository = Repository.new
    @calls = []
  end

  def self.add_gem(gem)
    @repository.add_feature(gem.to_s.to_sym, :version, gem::VERSION::STRING)
  end

  def self.find_feature(name)
    return self.repository[name] if name.is_a?(Symbol)

    self.repository[name.to_s.to_sym]
  end

  def self.delete_feature(name)
    sym = name.is_a?(Symbol) ? name : name.to_s.to_sym
    self.repository.delete(sym)
  end

  def self.features
    self.repository if block_given?
  end

  def self.active?(name)
    handle_caller(caller, __method__)
    feature = find_feature(name)
    return false unless feature
    feature[:value]
  end

  def self.inactive?(name)
    handle_caller(caller, __method__)
    !active?(name)
  end

  def self.active_since?(name, version)
    handle_caller(caller, __method__)
    Gem::Version.new(version) <= Gem::Version.new(find_feature(name)[:value])
  end

  def self.inactive_since?(name, version)
    handle_caller(caller, __method__)
    Gem::Version.new(version) > Gem::Version.new(find_feature(name)[:value])
  end

  def self.active_before?(name, version)
    handle_caller(caller, __method__)
    Gem::Version.new(version) > Gem::Version.new(find_feature(name)[:value])
  end

  def self.inactive_before?(name, version)
    handle_caller(caller, __method__)
    Gem::Version.new(version) <= Gem::Version.new(find_feature(name)[:value])
  end

  def self.active_between?(name, first_version, last_version)
    handle_caller(caller, __method__)
    Gem::Version.new(first_version) <= Gem::Version.new(find_feature(name)[:value]) && Gem::Version.new(last_version) >= Gem::Version.new(find_feature(name)[:value])
  end

  def self.handle_caller(caller_stack, method)
    return unless @config.monitoring == :enabled

    @calls << { method: method.to_sym, caller: caller_stack[0] }
    @calls = @calls.uniq
  end
end

loader.eager_load
