class MonthlyArchiveQuery < CreatedDurationEntriesQuery
  def initialize(time)
    super('year', time)
  end
end
