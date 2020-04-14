# frozen_string_literal: true

require 'rails_helper'

module ShowoffApi
  module Client
    describe VisibleWidget do
      describe 'save' do
        let(:widget_client) do
          VisibleWidget.new(
            ENV['API_ADDRESS'], ENV['CLIENT_ID'], ENV['CLIENT_SECRET']
          )
        end

        context 'with term' do
          let(:cassette_name) { 'get_visible_widget_by_term' }
          let(:term) { 'a' }
          it 'return widgets in data attribute' do
            VCR.use_cassette(cassette_name) do
              result = widget_client.visible(term)
              expect(result[:data][:widgets].size).to eq(20)
              keys = ['id', 'name', 'description', 'kind', 'user', 'owner']
              expect(result[:data][:widgets][0].keys).to contain_exactly(*keys)
            end
          end

          it 'return success in status attribute' do
            VCR.use_cassette(cassette_name) do
              result = widget_client.visible(term)
              expect(result[:status]).to eq(:success)
            end
          end

          it 'return hash with indifferent access' do
            VCR.use_cassette(cassette_name) do
              result = widget_client.visible(term)
              expect(result).to be_a_kind_of(
                ActiveSupport::HashWithIndifferentAccess
              )
            end
          end
        end

        context 'without term' do
          let(:cassette_name) { 'get_visible_widget' }
          it 'return widgets in data attribute' do
            VCR.use_cassette(cassette_name) do
              result = widget_client.visible
              expect(result[:data][:widgets].size).to eq(20)
              keys = ['id', 'name', 'description', 'kind', 'user', 'owner']
              expect(result[:data][:widgets][0].keys).to contain_exactly(*keys)
            end
          end

          it 'return success in status attribute' do
            VCR.use_cassette(cassette_name) do
              result = widget_client.visible
              expect(result[:status]).to eq(:success)
            end
          end

          it 'return hash with indifferent access' do
            VCR.use_cassette(cassette_name) do
              result = widget_client.visible
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
