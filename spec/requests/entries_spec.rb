require 'spec_helper'

describe 'GET /', type: :feature do
  before do
    @entry = Entry.create(body: 'my entry')
  end

  it "has the entry" do
    visit '/'
    within 'article' do
      expect(page).to have_content('my entry')
    end
  end
end
