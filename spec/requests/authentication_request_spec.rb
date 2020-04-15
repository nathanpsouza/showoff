# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
  describe 'POST #create' do
    let(:email) { 'foo@rspec.com' }
    let(:password) { '123123123' }

    let(:user) do
      {
        email: email,
        password: password
      }
    end

    let(:token_keys) do
      %w[access_token token_type expires_in refresh_token scope created_at]
    end

    context 'with valid credentials' do
      let(:cassette_name) { 'post_authenticate_user' }

      it 'return http status ok' do
        VCR.use_cassette(cassette_name) do
          post '/authentication', params: { user: user }
          expect(response).to have_http_status(:ok)
        end
      end

      it 'return success on status' do
        VCR.use_cassette(cassette_name) do
          post '/authentication', params: { user: user }
          json_response = JSON.parse(response.body)
          expect(json_response['status']).to eq('success')
        end
      end

      it 'return user information inside json' do
        VCR.use_cassette(cassette_name) do
          post '/authentication', params: { user: user }
          json_response = JSON.parse(response.body)
          expect(json_response['data']['token'].keys).to(
            contain_exactly(*token_keys)
          )
        end
      end
    end

    context 'with invalid credentials' do
      let(:cassette_name) { 'post_authenticate_invalid_user' }
      let(:password) { 'wrong!' }

      it 'return http status unprocessable_entity' do
        VCR.use_cassette(cassette_name) do
          post '/authentication', params: { user: user }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      it 'return error on status' do
        VCR.use_cassette(cassette_name) do
          post '/authentication', params: { user: user }
          json_response = JSON.parse(response.body)
          expect(json_response['status']).to eq('error')
        end
      end

      it 'return user information inside json' do
        VCR.use_cassette(cassette_name) do
          post '/authentication', params: { user: user }
          json_response = JSON.parse(response.body)
          error_message = 'There was an error logging in. Please try again.'
          expect(json_response['data']).to eq(error_message)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'redirect to root page' do
      delete '/authentication'
      expect(response).to redirect_to(root_path)
    end
  end
end
