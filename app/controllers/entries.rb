Deary::App.controllers :entries do
  get :index, '/' do
    @entries = Entry.order(:created_at).reverse
    render 'entries/index'
  end

  %r{(/\d{4}/\d{2}/\d{2}/\d{6})(?:\.(json))?}.tap do |permalink_pattern|
    get :show, permalink_pattern do |path, format|
      @entry = Entry.where(path: path).first or halt 404

      if format == 'json'
        content_type :json
        @entry.to_hash.to_json
      else
        @page_title = @entry.title
        render 'entries/show'
      end
    end

    patch :update, permalink_pattern do
      halt 400 unless request.content_type == 'application/json'

      @entry = Entry.where(path: request.path).first or halt 404
      body = JSON.parse(request.body.string)

      if @entry.update(body.slice('title', 'body'))
        halt 200
      else
        logger.warn "Bad Request: #{params}"
        halt 400
      end
    end
  end
end
