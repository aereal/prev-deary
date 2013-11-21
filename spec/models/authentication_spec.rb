require 'spec_helper'

describe Authentication do
  describe ".new_from_password" do
    let(:password) { 'dankogai' }
    let(:authentication) { described_class.new_from_password(password) }

    describe '#authenticate' do
      context "when given valid password" do
        let(:valid_password) { 'dankogai' }

        it "succeeds authentication" do
          expect(authentication.authenticate(valid_password)).to be_true
        end
      end

      context "when given **invalid** password" do
        let(:invalid_password) { 'kogaidan' }

        it "fails authentication" do
          expect(authentication.authenticate(invalid_password)).to be_false
        end
      end
    end

    describe '#authenticate!' do
      context "when given valid password" do
        let(:valid_password) { 'dankogai' }

        it "succeeds authentication" do
          expect { authentication.authenticate!(valid_password) }.not_to raise_error
        end
      end

      context "when given **invalid** password" do
        let(:invalid_password) { 'kogaidan' }

        it "fails authentication" do
          expect { authentication.authenticate!(invalid_password) }.to raise_error(Authentication::InvalidAuthentication)
        end
      end
    end
  end
end
