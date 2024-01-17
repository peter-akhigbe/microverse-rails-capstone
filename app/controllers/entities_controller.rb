class EntitiesController < ApplicationController
  before_action :set_entity, only: %i[show edit update destroy]

  def index
    @entities = Entity.all
  end

  def show
    # Implement as needed
  end

  def new
    @entity = Entity.new
  end

  def create
    @entity = Entity.new(entity_params)

    if @entity.save
      redirect_to @entity, notice: 'Entity was successfully created.'
    else
      render :new
    end
  end

  def edit
    # Implement as needed
  end

  def update
    if @entity.update(entity_params)
      redirect_to @entity, notice: 'Entity was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @entity.destroy
    redirect_to entities_url, notice: 'Entity was successfully destroyed.'
  end

  private

  def set_entity
    @entity = Entity.find(params[:id])
  end

  def entity_params
    params.require(:entity).permit(:name, :amount, :author_id)
  end
end
