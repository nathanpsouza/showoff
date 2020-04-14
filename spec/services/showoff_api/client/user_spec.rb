# frozen_string_literal: true

require 'rails_helper'

module ShowoffApi
  module Client
    describe User do
      describe 'save' do
        let(:email) { 'foo@rspec.com' }
        let(:first_name) { 'rspec' }
        let(:last_name) { 'test' }
        let(:password) { '123123123' }

        let(:user) do
          {
            email: email,
            first_name: first_name,
            last_name: last_name,
            password: password
          }
        end

        let(:user_client) do
          User.new(ENV['API_ADDRESS'], ENV['CLIENT_ID'], ENV['CLIENT_SECRET'])
        end

        context 'with valid data' do
          let(:cassette_name) { 'post_valid_user' }
          it 'return user in data attribute' do
            VCR.use_cassette(cassette_name) do
              result = user_client.save(user)
              expect(result[:data][:user]).to be_present
            end
          end

          it 'return success in status attribute' do
            VCR.use_cassette(cassette_name) do
              result = user_client.save(user)
              expect(result[:status]).to eq(:success)
            end
          end

          it 'return hash with indifferent access' do
            VCR.use_cassette(cassette_name) do
              result = user_client.save(user)
              expect(result).to be_a_kind_of(
                ActiveSupport::HashWithIndifferentAccess
              )
            end
          end
        end

        context 'with invalid data' do
          let(:email) { nil }
          let(:password) { '123123' }
          let(:cassette_name) { 'post_invalid_user' }

          it 'return error message in data attribute' do
            VCR.use_cassette(cassette_name) do
              result = user_client.save(user)
              expect(result[:data]).to eq('Email can\'t be blank')
            end
          end

          it 'return error in status attribute' do
            VCR.use_cassette(cassette_name) do
              result = user_client.save(user)
              expect(result[:status]).to eq(:error)
            end
          end

          it 'return hash with indifferent access' do
            VCR.use_cassette(cassette_name) do
              result = user_client.save(user)
              expect(result).to be_a_kind_of(
                ActiveSupport::HashWithIndifferentAccess
              )
            end
          end
        end
      end

      describe 'update' do
        let(:email) { 'foo@rspec.com' }
        let(:first_name) { 'rspec' }
        let(:last_name) { 'test' }
        let(:password) { '123123123' }

        let(:user) do
          {
            email: email,
            first_name: first_name,
            last_name: last_name,
            password: password
          }
        end

        let(:user_client) do
          User.new(ENV['API_ADDRESS'], ENV['CLIENT_ID'], ENV['CLIENT_SECRET'])
        end

        context 'with valid data' do
          let(:cassette_name) { 'post_valid_user' }
          it 'return user in data attribute' do
            VCR.use_cassette(cassette_name) do
              result = user_client.save(user)
              expect(result[:data][:user]).to be_present
            end
          end

          it 'return success in status attribute' do
            VCR.use_cassette(cassette_name) do
              result = user_client.save(user)
              expect(result[:status]).to eq(:success)
            end
          end

          it 'return hash with indifferent access' do
            VCR.use_cassette(cassette_name) do
              result = user_client.save(user)
              expect(result).to be_a_kind_of(
                ActiveSupport::HashWithIndifferentAccess
              )
            end
          end
        end

        context 'with invalid data' do
          let(:email) { nil }
          let(:password) { '123123' }
          let(:cassette_name) { 'post_invalid_user' }

          it 'return error message in data attribute' do
            VCR.use_cassette(cassette_name) do
              result = user_client.save(user)
              expect(result[:data]).to eq('Email can\'t be blank')
            end
          end

          it 'return error in status attribute' do
            VCR.use_cassette(cassette_name) do
              result = user_client.save(user)
              expect(result[:status]).to eq(:error)
            end
          end

          it 'return hash with indifferent access' do
            VCR.use_cassette(cassette_name) do
              result = user_client.save(user)
              expect(result).to be_a_kind_of(
                ActiveSupport::HashWithIndifferentAccess
              )
            end
          end
        end
      end
    end
  end
end
