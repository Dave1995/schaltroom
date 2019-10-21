# frozen_string_literal: true

require_relative 'test_helper'

class WithConfigAndRepositoryTest < Minitest::Test
  def test_test_block_feature
    Schaltroom.add_feature(:active, :boolean, false)
    repository = Schaltroom::Repository.new
    repository.add_feature(:active, :boolean, true)
    refute(Schaltroom.active?(:active))
    Schaltroom.with_config_and_repository(Schaltroom.config, repository) do
      assert(Schaltroom.active?(:active))
    end
    refute(Schaltroom.active?(:active))
  end

  def test_merge_repository
    Schaltroom.add_feature(:active1, :boolean, true)
    repository = Schaltroom::Repository.new
    repository.add_feature(:active2, :boolean, true)
    assert(Schaltroom.active?(:active1))
    refute(Schaltroom.active?(:active2))
    Schaltroom.with_config_and_repository(Schaltroom.config, repository) do
      assert(Schaltroom.active?(:active1))
      assert(Schaltroom.active?(:active2))
    end
    assert(Schaltroom.active?(:active1))
    refute(Schaltroom.active?(:active2))
  end
end
