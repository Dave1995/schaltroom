# frozen_string_literal: true

module Schaltroom
  # configuration class for Schaltroom
  class Config
    attr_accessor :monitoring, :monitoring_file

    # default values
    def initialize
      @monitoring = :disabled
      @monitoring_file = nil
    end
  end
end
