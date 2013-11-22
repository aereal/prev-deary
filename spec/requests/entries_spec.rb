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

  context "when logged in", js: true do
    let(:password) { 'kogaidan' }
    let(:user) { FactoryGirl.build(:user, password: password) }

    before do
      user.save

      visit '/-/login'
      fill_in 'User', with: user.name
      fill_in 'Password', with: password
      click_button 'login'
    end

    it "succeeds to create a new entry" do
      click_on 'addnew'
      within '#new-entry' do
        fill_in 'entry-title', with: 'my new entry'
        fill_in 'entry-body', with: 'my new body'
        click_on 'ok'
      end
      expect(page).to have_css('article:first-child')
      within 'article:first-child' do
        expect(page).to have_content('my new entry')
        expect(page).to have_content('my new body')
      end
    end

    it "succeeds to update the entry", js: true do
      pending "Unexpectedly request body is empty..."

      expect(page).to have_css('article:first-child')
      within 'article:first-child' do
        click_on 'edit'
        sleep 0.1
        fill_in 'entry-title', with: 'updated title'
        fill_in 'entry-body', with: 'updated body'
        click_on 'ok'
      end
      expect(page).to have_css('article:first-child')
      within 'article:first-child' do
        expect(page).to have_text('updated title')
        expect(page).to have_text('updated body')
      end
    end
  end
end
