class RubiesController < ApplicationController
  before_action :set_ruby, only: [:show, :update, :destroy]

  # GET /rubies
  def index
    @rubies = Ruby.all

    render json: @rubies
  end

  # GET /rubies/1
  def show
    render json: @ruby
  end

  # POST /rubies
  def create
    @ruby = Ruby.new(ruby_params)

    if @ruby.save
      render json: @ruby, status: :created, location: @ruby
    else
      render json: @ruby.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rubies/1
  def update
    if @ruby.update(ruby_params)
      render json: @ruby
    else
      render json: @ruby.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rubies/1
  def destroy
    @ruby.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ruby
      @ruby = Ruby.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ruby_params
      params.require(:ruby).permit(:name, :price)
    end
end
