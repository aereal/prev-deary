require 'spec_helper'

describe User do
  describe '#authenticate!' do
    context 'with valid password' do
      let(:name) { 'internet' }
      let(:password) { 'dankogai' }
      let(:valid_password) { password }
      let(:user) { User.create_with_digest(name: name, password: password) }

      it "succeeds authentication" do
        expect { user.authenticate!(valid_password) }.not_to raise_error
      end
    end

    context 'with invalid password' do
      let(:name) { 'internet' }
      let(:password) { 'dankogai' }
      let(:invalid_password) { 'kogaidan' }
      let(:user) { User.create_with_digest(name: name, password: password) }

      it "succeeds authentication" do
        expect { user.authenticate!(invalid_password) }.to raise_error(User::InvalidAuthority)
      end
    end
  end
end
