Deary::App.controllers :sessions do
  get :login, '/-/login' do
    render 'sessions/login'
  end

  post :create, '/-/sessions' do
    begin
      auth = Oj.load(request.body.string).symbolize_keys
      user = User.where(name: auth[:name]).first or halt 404
      user.authenticate!(auth[:password])
      session[:user_id] = user.id
    rescue Oj::ParseError
      halt 400
    rescue User::InvalidAuthority
      halt 403
    else
      status 200
    end
  end

  delete :logout, '/-/sessions' do
    session[:user_id] = nil
    halt 204
  end
end
