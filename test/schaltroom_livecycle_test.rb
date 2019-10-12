# frozen_string_literal: true

require_relative 'test_helper'

class SchaltroomTest < Minitest::Test
  def test_config
    Schaltroom.repository do |repository|
      repository.add_feature(:active, :boolean, true)
      repository.add_feature(:version, :version, '5.1.1.2')
    end
    assert(Schaltroom.active?('active'))
    assert(Schaltroom.active_since?(:version, '5.1'))
    Schaltroom.reset
    refute(Schaltroom.active?('active'))
  end
end
