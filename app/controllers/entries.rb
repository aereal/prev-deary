Deary::App.controllers :entries do
  helpers do
    def entry_params
      @_entry_params ||= JSON.parse(request.body.string)
    end
  end

  get :index, '/' do
    @entries = Entry.order(:created_at).reverse
    render 'entries/index'
  end

  post :create, '/-/entries' do
    halt 400 unless request.content_type == 'application/json'

    @entry = Entry.new(entry_params.slice('title', 'body'))

    if @entry.save
      content_type :json
      @entry.to_json
    else
      logger.warn "Bad request: #{request.body}"
      halt 400
    end
  end

  %r{(/\d{4}/\d{2}/\d{2}/\d{6})(?:\.(json))?}.tap do |permalink_pattern|
    get :show, permalink_pattern do |path, format|
      @entry = Entry.where(path: path).first or halt 404

      if format == 'json'
        content_type :json
        @entry.to_json
      else
        @page_title = @entry.title
        render 'entries/show'
      end
    end

    patch :update, permalink_pattern do
      halt 400 unless request.content_type == 'application/json'

      @entry = Entry.where(path: request.path).first or halt 404

      if @entry.update(entry_params.slice('title', 'body'))
        halt 200
      else
        logger.warn "Bad Request: #{request.body.string}"
        halt 400
      end
    end
  end
end
