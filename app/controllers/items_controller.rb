class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
      return render json: items, except: [:created_at, :updated_at]
    else
      items = Item.all
      return render json: items, include: :user
    end
  end

  def show
    item = Item.find(params[:id])
    render json: item, except: [:created_at, :updated_at]
  end

  def create
    user = User.find(params[:user_id])
    item = Item.create(item_params)
    user.items << item
    render json: item, except: [:created_at, :updated_at], status: :created
  end

  private

  def render_not_found_response
    render json: { error: "User/Item not found" }, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price)
  end

end
