class DailyArchiveQuery < CreatedDurationEntriesQuery
  def initialize(time)
    super('day', time)
  end
end
