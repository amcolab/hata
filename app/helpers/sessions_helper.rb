module SessionsHelper
  def current_user
    return unless session[:user_id]
    User.find_by_id(session[:user_id])
  end
end
