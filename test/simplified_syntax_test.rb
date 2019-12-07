# frozen_string_literal: true

require_relative 'test_helper'

class SimplifiedSyntaxTest < Minitest::Test
  def test_symplified_syntax_with_version
    Schaltroom.repository do |repository|
      repository.add_feature(:active, :boolean, true)
      repository.add_feature(:rails, :version, '5.1.1.2')
    end
    assert(Schaltroom[:rails] >= '5.0')
    assert(Schaltroom[:rails] >= '5.1.1.2')
    refute(Schaltroom[:rails] >= '6.0')
    assert(Schaltroom[:rails] > '5.0')
    refute(Schaltroom[:rails] > '5.1.1.2')
    assert(Schaltroom[:rails] == '5.1.1.2')
    refute(Schaltroom[:rails] == '6.0')
    assert(Schaltroom[:rails] < '6.0')
    refute(Schaltroom[:rails] < '5.1.1.2')
    refute(Schaltroom[:rails] < '5.0')
    assert(Schaltroom[:rails] <= '6.0')
    assert(Schaltroom[:rails] <= '5.1.1.2')
    refute(Schaltroom[:rails] <= '5.0')
    Schaltroom.reset
    assert_raises ArgumentError do
      refute(Schaltroom[:active] >= '5.0')
    end
  end
  
  def test_symplified_syntax_with_boolean
    Schaltroom.repository do |repository|
      repository.add_feature(:active, :boolean, true)
      repository.add_feature(:inactive, :boolean, false)
    end
    assert(Schaltroom[:active])
    refute(Schaltroom[:inactive])
    Schaltroom.reset
  end
end
