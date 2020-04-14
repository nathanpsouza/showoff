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

    context 'with valid credentials' do
      let(:cassette_name) { 'post_authenticate_user' }

      it 'return http status created' do
        VCR.use_cassette(cassette_name) do
          post '//authentication', params: { user: user }
          expect(response).to have_http_status(:ok)
        end
      end

      it 'return user information inside json' do
      end
    end

    context 'with invalid credentials' do
      let(:cassette_name) { 'post_authenticate_invalid_user' }
      let(:password) { 'wrong!' }

      it 'return http status created' do
        post '//authentication', params: { user: { email: 'n@n.com', password: '123123123' } }
        expect(response).to have_http_status(:ok)
      end

      it 'return user information inside json' do
      end
    end
  end
end
