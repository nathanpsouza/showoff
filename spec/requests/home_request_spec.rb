# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', type: :request do
  describe 'GET /index' do
    context 'without term' do
      let(:cassette_name)  { 'get_visible_widget' }

      it 'return http status ok' do
        VCR.use_cassette(cassette_name) do
          get '/'
          expect(response).to have_http_status(:ok)
        end
      end

      it 'render widget name on template' do
        VCR.use_cassette(cassette_name) do
          get '/'
          widget_title = '<h4 class="card-title">Edited name</h4>'
          expect(response.body).to include(widget_title)
        end
      end

      it 'render template home' do        
        VCR.use_cassette(cassette_name) do
          get '/'
          expect(response).to render_template('home/index')
        end
      end
    end

    context 'with term' do
      let(:cassette_name)  { 'get_visible_widget_by_term' }
      let(:term) { 'a' }
      
      it 'return http status ok' do
        VCR.use_cassette(cassette_name) do
          get "/?term=#{term}"
          expect(response).to have_http_status(:ok)
        end
      end

      it 'render widget name on template' do
        VCR.use_cassette(cassette_name) do
          get "/?term=#{term}"
          widget_title = '<h4 class="card-title">Edited name</h4>'
          expect(response.body).to include(widget_title)
        end
      end

      it 'render template home' do        
        VCR.use_cassette(cassette_name) do
          get "/?term=#{term}"
          expect(response).to render_template('home/index')
        end
      end
    end
  end
end
