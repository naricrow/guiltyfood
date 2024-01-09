class FoodsController < ApplicationController
  
  def index
    @foods = Food.all
  end

  def new
    @food =Food.new
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      redirect_to '/'
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def food_params
    params.require(:food).permit(:image, :name, :content).merge(user_id: current_user.id)
  end

end
