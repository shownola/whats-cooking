class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:edit, :update, :show, :destroy]
  before_action :require_admin, only: [:edit]
  # before_action :require_admin, except: [:show, :index, :udpate, :create, :new]
  # before_action :sort_ingredient, only: [:index, :show]
  
  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
    # @ingredients, @alphaParams = Ingredient.all.alpha_paginate(params[:letter]){|ingredient| ingredient.name}
  end
  
  def new
    @ingredient = Ingredient.new
  end
  
  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = "Ingredient was successfully created"
      redirect_to ingredient_path(@ingredient)
    else
      render 'new'
    end
  end

  def edit
  
  end
  
  def update
    if @ingredient.update(ingredient_params)
      flash[:success] = "Ingredient was successfully edited"
      redirect_to @ingredient
    else
      render 'edit'
    end
  end
  
  def show
    @ingredient_recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 5)
  end
  
  def destroy
  
  end
  
  private
  
  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
  
  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end
  
  def require_admin
    if !logged_in? || (logged_in? and !current_chef.admin?)
      flash[:danger] = "Only admin Users can perform that action"
      redirect_to ingredients_path
    end
  end
  
  
  # def sort_ingredient
  #   @ingredient = Ingredient.all.sort
  # end
  
  
  

end

