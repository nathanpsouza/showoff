# frozen_string_literal: true

require 'rails_helper'

module ShowoffApi
  module Client
    describe Authentication do
      let(:authentication_client) do
        Authentication.new(
          ENV['API_ADDRESS'],
          ENV['CLIENT_ID'],
          ENV['CLIENT_SECRET']
        )
      end

      describe 'login' do
        let(:email) { 'foo@rspec.com' }
        let(:password) { '123123123' }

        let(:user) do
          {
            email: email,
            password: password
          }
        end

        context 'with valid credentials' do
          let(:cassette_name) { 'post_authenticate_user' }

          it 'return token inside data' do
            VCR.use_cassette(cassette_name) do
              result = authentication_client.login(user)
              expect(result[:data][:token]).to be_present
            end
          end

          it 'return status success' do
            VCR.use_cassette(cassette_name) do
              result = authentication_client.login(user)
              expect(result[:status]).to eq(:success)
            end
          end

          it 'return hash with indifferent access' do
            VCR.use_cassette(cassette_name) do
              result = authentication_client.login(user)
              expect(result).to be_a_kind_of(
                ActiveSupport::HashWithIndifferentAccess
              )
            end
          end
        end

        context 'with invalid credentials' do
          let(:cassette_name) { 'post_authenticate_invalid_user' }
          let(:password) { 'wrong!' }
          it 'return token inside data' do
            VCR.use_cassette(cassette_name) do
              result = authentication_client.login(user)
              expect(result[:data]).to(
                eq('There was an error logging in. Please try again.')
              )
            end
          end

          it 'return status success' do
            VCR.use_cassette(cassette_name) do
              result = authentication_client.login(user)
              expect(result[:status]).to eq(:error)
            end
          end

          it 'return hash with indifferent access' do
            VCR.use_cassette(cassette_name) do
              result = authentication_client.login(user)
              expect(result).to be_a_kind_of(
                ActiveSupport::HashWithIndifferentAccess
              )
            end
          end
        end
      end

      describe 'logout' do

      end

      describe 'refresh' do

      end
    end
  end
end
