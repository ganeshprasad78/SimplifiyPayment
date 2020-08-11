require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  Group.delete_all
  groups = [{ name: 'Group A' }, { name: 'Group B' }, { name: 'Group C' }]

  test 'should get index' do
    get groups_url, as: :json
    assert_response :success
  end

  test 'should create group' do
    assert_difference 'Group.count', 3 do
      groups.each do |group|
        post groups_url, params: { group: group }, as: :json
      end
    end
    assert_response 201
  end

  test 'should show group' do
    Group.all.each do |group|
      get group_url(group), as: :json
      assert_response :success
    end
  end

  test 'should update group' do
    group = Group.first
    put group_url(group), params: { group: { name: 'Group Update' } }
    assert_response :success
  end

  test 'should destroy group' do
    group = Group.first
    delete group_url(group)
    assert_response :success
  end
end
