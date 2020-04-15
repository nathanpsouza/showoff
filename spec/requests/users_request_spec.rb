# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do

  describe 'GET #new' do
    it 'return http status ok' do
      get '/users/new'
      expect(response).to have_http_status(:ok)
    end

    it 'render template new' do
      get '/users/new'
      expect(response).to render_template('users/new')
    end
  end

  describe 'POST create' do
    let(:email) { 'foo@rspec.com' }
    let(:first_name) { 'rspec' }
    let(:last_name) { 'test' }
    let(:password) { '123123123' }

    let(:user) do
      {
        email: email,
        first_name: first_name,
        last_name: last_name,
        password: password,
        password_confirmation: password
      }
    end

    context 'with valid data' do
      let(:cassette_name) { 'post_valid_user' }

      it 'redirect to root path' do
        VCR.use_cassette(cassette_name) do
          post '/users', params: { user: user }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'with invalid data' do
      let(:email) { nil }
      let(:cassette_name) { 'post_invalid_user' }

      it 'return http status unprocessable_entity' do
        VCR.use_cassette(cassette_name) do
          post '/users', params: { user: user }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      it 're-render new template' do
        VCR.use_cassette(cassette_name) do
          post '/users', params: { user: user }
          expect(response).to render_template('users/new')
        end
      end
    end
  end

  describe 'GET #edit' do
    context 'with logged user' do
      # Should see at docs how to mock session for request specs.
      # before do
      #   session[:user] = {
      #     "id"=>1,
      #     "name"=>"tyler Thunderbird",
      #     "images"=> { },
      #     "first_name"=>"tyler",
      #     "last_name"=>"Thunderbird"
      #   }
      # end
      # it 'return http status ok' do
      #   get '/users/edit'
      #   expect(response).to have_http_status(:ok)
      # end

      # it 'render template edit' do
      #   get '/users/edit'
      #   expect(response).to render_template('users/edit')
      # end
    end

    context 'without logged user' do
      it 'redirect to root path' do
        get '/users/edit'
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
