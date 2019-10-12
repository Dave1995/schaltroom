# frozen_string_literal: true

require_relative 'test_helper'

class SchaltroomTest < Minitest::Test
  def teardown
    Schaltroom.delete_feature(:active)
    Schaltroom.delete_feature(:inactive)
    Schaltroom.delete_feature(:version)
    Schaltroom.delete_feature(Rails)
    super
  end

  def test_active_boolean_feature_flags
    Schaltroom.add_feature(:active, :boolean, true)

    assert(Schaltroom.active?(:active))
    refute(Schaltroom.inactive?(:active))

    assert(Schaltroom.active?('active'))
    refute(Schaltroom.inactive?('active'))
  end

  def test_inactive_boolean_feature_flags
    Schaltroom.add_feature(:inactive, :boolean, false)

    assert(Schaltroom.inactive?(:inactive))
    refute(Schaltroom.active?(:inactive))

    assert(Schaltroom.inactive?('inactive'))
    refute(Schaltroom.active?('inactive'))
  end

  def test_version_feature_flags
    Schaltroom.add_feature(:version, :version, '5.1.1.2')
    assert(Schaltroom.active_since?(:version, '5.1'))
    refute(Schaltroom.active_before?(:version, '5.1'))
    refute(Schaltroom.active_since?(:version, '5.2'))
    assert(Schaltroom.active_before?(:version, '5.2'))
    assert(Schaltroom.active_since?(:version, '5.1.1.2'))
    refute(Schaltroom.active_before?(:version, '5.1.1.2'))
    assert(Schaltroom.active_before?(:version, '5.1.1.3'))
  end

  def test_active_between
    Schaltroom.add_feature(:version, :version, '5.1.1.2')
    assert(Schaltroom.active_between?(:version, '5.1', '5.2'))
    refute(Schaltroom.active_between?(:version, '5.1.2', '5.2'))
  end

  def test_gem
    Schaltroom.add_gem(Rails)
    assert(Schaltroom.active_since?(Rails, '4.2'))
    refute(Schaltroom.active_since?(Rails, '6.2'))
  end
end
