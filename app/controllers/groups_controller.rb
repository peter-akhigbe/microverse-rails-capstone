class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]

  def index
    @groups = current_user.groups.reverse
  end

  def show
    # set_group
  end

  def new
    @group = Group.new
    @icons = %w[home car shopping school kids computer]
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      redirect_to groups_url, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  def edit
    # set_group
    @icons = %w[home car shopping school kids computer]
  end

  def update
    # set_group
    if @group.update(group_params)
      redirect_to @group, notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    # set_group
    @group.destroy
    redirect_to groups_url, notice: 'Group was successfully destroyed.'
  end

  private

  def set_group
    @group = current_user.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :icon, :user_id)
  end
end
