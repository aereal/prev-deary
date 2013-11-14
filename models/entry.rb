require 'kramdown'

class Entry < Sequel::Model
  dataset_module do
    def recently
      order(:created_at).reverse
    end

    def created_between(time_part, time)
      where(created_at: time.send("beginning_of_#{time_part}") .. time.send("end_of_#{time_part}"))
    end

    def in_year(time)
      self.created_between(:year, time)
    end

    def in_month(time)
      self.created_between(:month, time)
    end

    def in_day(time)
      self.created_between(:day, time)
    end
  end

  def before_validation
    self.created_at ||= Time.now
    self.path ||= self.created_at.strftime('/%Y/%m/%d/%H%M%S')
    self.formatted_body = Kramdown::Document.new(self.body).to_html
  end

  def before_save
    self.updated_at = Time.now
  end
end
