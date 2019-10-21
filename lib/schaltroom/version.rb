# frozen_string_literal: true

module Schaltroom
  def self.gem_version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 0
    MINOR = 0
    TINY  = 3

    STRING = [MAJOR, MINOR, TINY].compact.join('.')
  end
end
