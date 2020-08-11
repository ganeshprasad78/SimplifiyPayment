require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  test 'Valid Group' do
    group = Group.new(name: '')
    refute group.valid?, false
  end

  test 'Saves Group ' do
    group = Group.new(name: 'Group Save')
    assert	 group.save, true
  end
end
