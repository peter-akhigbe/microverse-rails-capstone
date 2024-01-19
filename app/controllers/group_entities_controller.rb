class GroupEntitiesController < ApplicationController
  before_action :set_group_entity, only: %i[show edit update destroy]

  def index
    @group_entities = GroupEntity.all
  end

  def show
    # okay
  end

  def new
    @group_entity = GroupEntity.new
  end

  def create
    @group_entity = GroupEntity.new(group_entity_params)

    if @group_entity.save
      redirect_to @group_entity, notice: 'GroupEntity was successfully created.'
    else
      render :new
    end
  end

  def edit
    # okay
  end

  def update
    if @group_entity.update(group_entity_params)
      redirect_to @group_entity, notice: 'GroupEntity was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @group_entity.destroy
    redirect_to group_entities_url, notice: 'GroupEntity was successfully destroyed.'
  end

  private

  def set_group_entity
    @group_entity = GroupEntity.find(params[:id])
  end

  def group_entity_params
    params.require(:group_entity).permit(:group_id, :entity_id)
  end
end
