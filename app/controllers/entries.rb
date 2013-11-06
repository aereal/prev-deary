Deary::App.controllers :entries do
  get :index, '/' do
    @entries = Entry.order(:created_at).reverse
    render 'entries/index'
  end

  get :show, %r{/\d{4}/\d{2}/\d{2}/\d{6}} do
    @entry = Entry.where(path: request.path).first or halt 404
    @page_title = @entry.title
    render 'entries/show'
  end
end
