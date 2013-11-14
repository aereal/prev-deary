Deary::App.controllers :sessions do
  get :login, '/-/login' do
    render 'sessions/login'
  end

  post :create, '/-/sessions' do
    begin
      auth = Oj.load(request.body.string).symbolize_keys
      user = User.where(name: auth[:name]).first
      user.authenticate!(auth[:password])
      session[:user_id] = user.id
      halt 200
    rescue Oj::ParseError
      halt 400
    rescue User::InvalidAuthority
      halt 403
    end
  end

  delete :logout, '/-/sessions' do
    session[:user_id] = nil
    halt 204
  end
end
