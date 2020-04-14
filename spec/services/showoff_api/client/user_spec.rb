# frozen_string_literal: true

require 'rails_helper'

module ShowoffApi
  module Client
    describe User do
      let(:token) do
        'f311c6ac1a39c0eb29a41ff602319b618e54381786e457f4cab08a10e700a72b'
      end

      let(:user_client) do
        User.new(
          token, ENV['API_ADDRESS'], ENV['CLIENT_ID'], ENV['CLIENT_SECRET']
        )
      end

      describe '#user' do
        let(:id) {1}

        context 'when user exists' do
          let(:cassette_name) { 'get_existing_user' }
          it 'return user in data attribute' do
            VCR.use_cassette(cassette_name) do
              result = user_client.user(id)
              expect(result[:data][:user]).to be_present
            end
          end

          it 'return success in status attribute' do
            VCR.use_cassette(cassette_name) do
              result = user_client.user(id)
              expect(result[:status]).to eq(:success)
            end
          end

          it 'return hash with indifferent access' do
            VCR.use_cassette(cassette_name) do
              result = user_client.user(id)
              expect(result).to be_a_kind_of(
                ActiveSupport::HashWithIndifferentAccess
              )
            end
          end
        end

        context 'when user do not exist' do
          let(:id) {-9999}
          let(:cassette_name) { 'get_no_existing_user' }
          it 'return error message in data attribute' do
            VCR.use_cassette(cassette_name) do
              result = user_client.user(id)
              expect(result[:data]).to eq('That user does not exist')
            end
          end

          it 'return error in status attribute' do
            VCR.use_cassette(cassette_name) do
              result = user_client.user(id)
              expect(result[:status]).to eq(:error)
            end
          end

          it 'return hash with indifferent access' do
            VCR.use_cassette(cassette_name) do
              result = user_client.user(id)
              expect(result).to be_a_kind_of(
                ActiveSupport::HashWithIndifferentAccess
              )
            end
          end
        end
      end

      describe '#save' do
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

        let(:token) { nil }

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

      describe '#update' do
        let(:email) { 'foo@rspec.com' }
        let(:first_name) { 'rspec edit' }
        let(:last_name) { 'test' }

        let(:user) do
          {
            email: email,
            first_name: first_name,
            last_name: last_name
          }
        end

        context 'with valid data' do
          let(:cassette_name) { 'put_valid_user' }
          it 'return user in data attribute' do
            VCR.use_cassette(cassette_name) do
              result = user_client.update(user)
              expect(result[:data][:user][:first_name]).to eq(first_name)
            end
          end

          it 'return success in status attribute' do
            VCR.use_cassette(cassette_name) do
              result = user_client.update(user)
              expect(result[:status]).to eq(:success)
            end
          end

          it 'return hash with indifferent access' do
            VCR.use_cassette(cassette_name) do
              result = user_client.update(user)
              expect(result).to be_a_kind_of(
                ActiveSupport::HashWithIndifferentAccess
              )
            end
          end
        end

        context 'with invalid data' do
          let(:email) { nil }
          let(:password) { '123123' }
          let(:cassette_name) { 'put_invalid_user' }

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
