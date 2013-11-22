require 'spec_helper'

describe UserAuthenticator do
  let(:password) { 'kogaidan' }
  let(:user) { FactoryGirl.build(:user, password: password) }

  before do
    user.save
  end

  describe '.authenticate' do
    #
  end
end
