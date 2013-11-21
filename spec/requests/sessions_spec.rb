require 'spec_helper'

describe '/-/sessions', js: true do
  let(:name) { 'dankogai' }
  let(:password) { 'kogaidan' }
  let(:authentication) { Authentication.new_from_password(password) }
  let!(:user) { User.create(name: name, password_digest: authentication.digest, password_salt: authentication.salt) }

  it "can create a new session" do
    visit '/-/login'
    fill_in 'User', with: name
    fill_in 'Password', with: password
    click_button 'login'
    expect(page).to have_link('addnew')
  end
end
