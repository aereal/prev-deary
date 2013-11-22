require 'spec_helper'

describe '/-/sessions', js: true do
  let(:password) { 'kogaidan' }
  let(:user) { FactoryGirl.build(:user, password: password) }

  before do
    user.save
  end

  it "can create a new session" do
    visit '/-/login'
    fill_in 'User', with: user.name
    fill_in 'Password', with: password
    click_button 'login'
    expect(page).to have_link('addnew')
  end
end
