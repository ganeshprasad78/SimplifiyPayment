class GroupsController < ApplicationController
  before_action :set_group, only: %i[show update destroy]

  def index
    @groups = Group.all
    json_response(@groups)
  end

  def create
    @group = Group.create!(group_params)
    json_response(@group, :created)
  end

  def show
    json_response(@group)
  end

  def update
    @group.update(group_params)
    head :no_content
  end

  def destroy
    @group.destroy
    head :no_content
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
