Deary::App.helpers do
  def request_body_as_json
    Oj.load(request.body.string).symbolize_keys
  rescue Oj::ParseError
    halt 400
  end
end
