require 'kramdown'

class Entry < Sequel::Model
  def before_validation
    self.created_at ||= Time.now
    self.path ||= self.created_at.strftime('/%Y/%m/%d/%H%M%S')
    self.formatted_body = Kramdown::Document.new(self.body).to_html
  end

  def before_save
    self.updated_at = Time.now
  end

  def to_json
    Oj.dump(self.to_hash.stringify_keys)
  end
end
