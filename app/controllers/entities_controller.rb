class EntitiesController < ApplicationController
  before_action :set_entity, only: %i[show edit update destroy]
  before_action :set_group

  def index
    # @group = Group.find(params[:group_id])

    @entities = @group.entities
  end

  def show
    # @group = Group.find(params[:group_id])
    # @entity = Entity.find(params[:id])
  end

  def new
    # @group = Group.find(params[:group_id])

    @entity = Entity.new
  end

  def create
    # @group = Group.find(params[:group_id])

    @entity = Entity.new(entity_params)
    @entity.author = current_user
    @entity.groups << @group

    if @entity.save
      redirect_to group_entity_path(@group, @entity), notice: 'Entity was successfully created.'
    else
      render :new
    end
  end

  def edit
    # @group = Group.find(params[:group_id])
    # @entity = Entity.find(params[:id])
  end

  def update
    # @group = Group.find(params[:group_id])
    # @entity = Entity.find(params[:id])

    if @entity.update(entity_params)
      redirect_to group_entity_path(@group, @entity), notice: 'Entity was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    # @entity = Entity.find(params[:id])

    @entity.destroy
    redirect_to group_entities_url, notice: 'Entity was successfully destroyed.'
  end

  private

  def set_entity
    @entity = Entity.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end


  def entity_params
    params.require(:entity).permit(:name, :amount, :author_id)
  end
end
