class ItemsController < ApplicationController
  before_action :require_user
  
  def vote
    item = Item.find(params[:id])
    vote1 = Vote.new
    vote1.item = item
    vote1.user = current_user
    vote1.vote = true
    if vote1.save
      flash[:notice] = "Thanks for voting!"
    else
      flash[:error] = "vote could not be cast, nyucca"
    end
    redirect_to :back
  end

  def group_params
    params.require(:item).permit!
  end

end