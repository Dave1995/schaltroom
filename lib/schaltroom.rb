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

  def self.[](item)
    handle_caller(caller, __method__, item)
    feature = Schaltroom.find_feature(item)
    raise ArgumentError, "Feature: #{item} is unknown. Please add it to your Schaltroom.config" if feature.nil?
    if feature[:type] == :boolean
      return feature[:value]
    else
      Feature.new(feature)
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
    handle_caller(caller, __method__, name)
    feature = find_feature(name)
    return false unless feature
    feature[:value]
  end

  def self.inactive?(name)
    handle_caller(caller, __method__, name)
    !active?(name)
  end

  def self.active_since?(name, version)
    handle_caller(caller, __method__, name)
    Gem::Version.new(version) <= Gem::Version.new(find_feature(name)[:value])
  end

  def self.inactive_since?(name, version)
    handle_caller(caller, __method__, name)
    Gem::Version.new(version) > Gem::Version.new(find_feature(name)[:value])
  end

  def self.active_before?(name, version)
    handle_caller(caller, __method__, name)
    Gem::Version.new(version) > Gem::Version.new(find_feature(name)[:value])
  end

  def self.inactive_before?(name, version)
    handle_caller(caller, __method__, name)
    Gem::Version.new(version) <= Gem::Version.new(find_feature(name)[:value])
  end

  def self.active_between?(name, first_version, last_version)
    handle_caller(caller, __method__, name)
    Gem::Version.new(first_version) <= Gem::Version.new(find_feature(name)[:value]) && Gem::Version.new(last_version) >= Gem::Version.new(find_feature(name)[:value])
  end

  def self.handle_caller(caller_stack, method, feature_name)
    return unless @config.monitoring == :enabled

    @calls << { feature_name: feature_name, method: method.to_sym, caller: caller_stack[0] }
    @calls = @calls.uniq
  end

  def self.with_config_and_repository(config, repository)
    return unless block_given?
    current_config = @config
    current_repository = @repository
    @config = config
    @repository = @repository.merge(repository)
    yield
    @config = current_config
    @repository = current_repository
  end
end

loader.eager_load
