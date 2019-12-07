# frozen_string_literal: true

module Schaltroom
  # configuration class for Schaltroom
  class Feature
    def initialize(feature)
      @value = feature[:value]
    end

    define_method :>= do |str|
      Gem::Version.new(@value) >= Gem::Version.new(str)
    end

    define_method :> do |str|
      Gem::Version.new(@value) > Gem::Version.new(str)
    end

    define_method :== do |str|
      Gem::Version.new(@value) == Gem::Version.new(str)
    end

    define_method :< do |str|
      Gem::Version.new(@value) < Gem::Version.new(str)
    end

    define_method '<='.to_sym do |str|
      Gem::Version.new(@value) <= Gem::Version.new(str)
    end
  end
end