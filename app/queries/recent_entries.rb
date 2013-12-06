class RecentEntriesQuery
  def call(dataset)
    dataset.order(:created_at).reverse
  end
end
