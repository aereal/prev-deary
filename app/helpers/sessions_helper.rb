# Helper methods defined here can be accessed in any controller or view in the application

Deary::App.helpers do
  def current_user
    @current_user ||= User.where(id: session[:user_id]).first
  end

  def logged_in?
    !!session[:user_id]
  end
end
