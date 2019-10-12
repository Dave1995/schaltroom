# frozen_string_literal: true

require_relative '../lib/schaltroom'
require 'minitest/autorun'

module Minitest
  class Test
    def setup
      super
    end

    def teardown
      super
    end
  end
end

require 'minitest/reporters'
Minitest::Reporters.use!([Minitest::Reporters::DefaultReporter.new,
                          Minitest::Reporters::JUnitReporter.new])

# provides gem version feature test
module Rails
  def self.gem_version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 5
    MINOR = 2
    TINY  = 3
    PRE   = nil

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
  end
end
