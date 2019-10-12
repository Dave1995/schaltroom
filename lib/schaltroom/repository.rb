# frozen_string_literal: true

module Schaltroom
  # features class for Schaltroom
  class Repository < Hash
    def add_feature(name, type, value)
      sym = name.is_a?(Symbol) ? name : name.to_s.to_sym
      if type == :boolean
        self[sym] = { type: :boolean, value: value }
      elsif type == :version
        self[sym] = { type: :version, value: value }
      else
        raise Exception, "unknown type: #{type.to_sym}"
      end
    end
  end
end
