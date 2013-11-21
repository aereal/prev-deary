Deary::App.controllers :sessions do
  get :login, '/-/login' do
    render 'sessions/login'
  end

  post :create, '/-/sessions' do
    auth = request_body_as_json
    user = User.where(name: auth[:name]).first or halt 404
    UserAuthentication.authenticate(user: user, password: auth[:password]) or halt 403
    session[:user_id] = user.id
    status 200
  end

  delete :logout, '/-/sessions' do
    session[:user_id] = nil
    halt 204
  end
end
