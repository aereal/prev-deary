class CreatedDurationEntriesQuery
  def initialize(time_part, time)
    @time_part, @time = time_part, time
  end

  def call(dataset)
    dataset.where(created_at: @time.send("beginning_of_#{@time_part}") .. @time.send("end_of_#{@time_part}"))
  end
end
