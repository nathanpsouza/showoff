# frozen_string_literal: true

require 'rails_helper'

module ShowoffApi
  module Client
    describe Base do
      describe 'initialize' do
        let(:user_client) { Base.new('https://foo', 'id', 'secret') }

        it 'set api address' do
          expect(user_client.api_address).to eq('https://foo')
        end

        it 'set client id' do
          expect(user_client.client_id).to eq('id')
        end

        it 'set client secret' do
          expect(user_client.client_secret).to eq('secret')
        end
      end
    end
  end
end
