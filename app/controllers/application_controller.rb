class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?


  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    if !logged_in?
      flash[:error] = 'Must be logged in to do that.'
      redirect_to root_path
    end
  end

  def deep_find(key, object=self, found=nil)
    if object.respond_to?(:key?) && object.key?(key)
      return object[key]
    elsif object.is_a? Enumerable
      object.find { |*a| found = deep_find(key, a.last) }
      return found
    end
  end

  def next_group_id
    exclude_my_groups = Group.where.not(user: current_user)
    return 0 if exclude_my_groups.empty?
    exclude_voted_on = exclude_my_groups.reject{|g| user_vote_this_group?(g)}
    return 0 if exclude_voted_on.empty?
    exclude_voted_on.sample.id
  end

  def user_vote_this_group?(group)
    group.items.any?{|item| !item.votes.where(user: current_user).empty?}
  end

end
