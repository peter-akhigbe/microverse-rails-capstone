class EntitiesController < ApplicationController
  before_action :set_entity, only: %i[show edit update destroy]
  before_action :set_group

  def index
    # set_group
    @entities = current_user.groups.find(params[:group_id]).entities.reverse
  end

  def show
  #   set_group
  #  set_entity
  end

  def new
    # set_group
    @entity = Entity.new
  end

  def create
    # set_group
    @entity = Entity.new(entity_params)
    @entity.author = current_user
    @entity.groups << @group

    if @entity.save
      redirect_to group_entities_path(@group, @entity), notice: 'Entity was successfully created.'
    else
      render :new
    end
  end

  def edit
    # set_group
    # set_entity
  end

  def update
    # set_group
    # set_entity
    if @entity.update(entity_params)
      redirect_to group_entity_path(@group, @entity), notice: 'Entity was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    # set_group
    # set_entity
    @entity.destroy
    redirect_to group_entities_url, notice: 'Entity was successfully destroyed.'
  end

  private

  def set_entity
    @entity = current_user.entities.find(params[:id])
  end

  def set_group
    @group = current_user.groups.find(params[:group_id])
  end


  def entity_params
    params.require(:entity).permit(:name, :amount, :author_id)
  end
end
