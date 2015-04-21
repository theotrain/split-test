class GroupsController < ApplicationController
  before_action :require_user

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def vote
    n = next_group_id
    if n == 0
      @group = []
    else
      @group = Group.find(n)
    end
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if total_items(group_params) < 2
      flash[:alert] = "Fill in at least 2 items to create split test."
      render :new
      return
    end
    if @group.save
      flash[:notice] = "New split test was created!"
      redirect_to statistics_path
    else
      @group.errors.full_messages.each do |msg|
        flash[:alert] = msg
      end
      render :new
    end
  end

  def statistics
    @groups = Group.where(user: current_user)
  end

  def group_params
    params.require(:group).permit!
  end

  def total_items(params)
    3 - (0..2).count{ |i| deep_find( i.to_s, params)['text'] == "" }
  end

end