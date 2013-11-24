require 'spec_helper'

describe '/-/sessions', js: true do
  let(:valid_password) { 'kogaidan' }
  let(:invalid_password) { 'k0gaidan' }
  let(:user) { FactoryGirl.build(:user, password: valid_password) }

  before do
    user.save
  end

  context "with valid password" do
    it "can create a new session" do
      visit '/-/login'
      fill_in 'User', with: user.name
      fill_in 'Password', with: valid_password
      click_button 'login'
      expect(page).to have_link('addnew')
    end
  end

  context "with invalid password" do
    it "can not create a new session" do
      visit '/-/login'
      fill_in 'User', with: user.name
      fill_in 'Password', with: invalid_password
      click_button 'login'
      sleep 0.1
      expect(page).to have_no_link('addnew')
      expect(page).to have_css('.error')
    end
  end
end
