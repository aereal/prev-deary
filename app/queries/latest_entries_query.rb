class LatestEntriesQuery < RecentEntriesQuery
  def initialize(limit)
    @limit = limit
  end

  def call(dataset)
    recent = super(dataset)
    recent.limit(@limit)
  end
end
