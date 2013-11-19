Deary::App.controllers :entries do
  helpers do
    def entry_params
      @_entry_params ||= Oj.load(request.body.string)
    end
  end

  before :create, :update do
    unless logged_in?
      halt 403
    end
  end

  get :index, '/' do
    @entries = Entry.latest
    render 'entries/index'
  end

  post :create, '/-/entries' do
    halt 400 unless request.content_type == 'application/json'

    @entry = Entry.new(entry_params.slice('title', 'body'))

    if @entry.save
      content_type :json
      Oj.dump(@entry.to_hash.stringify_keys)
    else
      logger.warn "Bad request: #{request.body}"
      halt 400
    end
  end

  get :yearly_archive, %r{/(\d{4})/?} do |year|
    @archive_at = Time.new(year.to_i(10))
    @entries = Entry.in_year(@archive_at).recently
    render 'entries/index'
  end

  get :monthly_archive, %r{/(\d{4})/(\d{2})/?} do |year, month|
    @archive_at = Time.new(year.to_i(10), month.to_i(10))
    @entries = Entry.in_month(@archive_at).recently
    render 'entries/index'
  end

  get :daily_archive, %r{/(\d{4})/(\d{2})/(\d{2})/?} do |year, month, day|
    @archive_at = Time.new(year.to_i(10), month.to_i(10), day.to_i(10))
    @entries = Entry.in_day(@archive_at).recently
    render 'entries/index'
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
