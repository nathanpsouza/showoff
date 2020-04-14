# frozen_string_literal: true

require 'rails_helper'

module ShowoffApi
  describe Client do
    before do
      ENV['API_ADDRESS'] = 'https://foo'
      ENV['CLIENT_ID'] = 'id'
      ENV['CLIENT_SECRET'] = 'secret'
    end

    describe 'Client.verify_api_credentials' do
      it_behaves_like 'a service with api credentials' do
        let(:method_call) { -> { Client.verify_api_credentials } }
      end
    end

    describe 'Client.user' do
      it 'return a new instance of User' do
        expect(Client.user).to be_a_kind_of(::ShowoffApi::Client::User)
      end

      it_behaves_like 'a service with api credentials' do
        let(:method_call) { -> { Client.user } }
      end
    end

    describe 'Client.visible_widget' do
      it 'return a new instance of VisibleWidget' do
        expect(Client.visible_widget).to(
          be_a_kind_of(::ShowoffApi::Client::VisibleWidget)
        )
      end

      it_behaves_like 'a service with api credentials' do
        let(:method_call) { -> { Client.visible_widget } }
      end
    end

    describe 'Client.authentication' do
      it 'return a new instance of Authentication' do
        expect(Client.authentication).to(
          be_a_kind_of(::ShowoffApi::Client::Authentication)
        )
      end

      it_behaves_like 'a service with api credentials' do
        let(:method_call) { -> { Client.authentication } }
      end
    end

    describe 'Client.widget' do
      it 'return a new instance of Widget' do
        expect(Client.widget('token')).to(
          be_a_kind_of(::ShowoffApi::Client::Widget)
        )
      end

      it_behaves_like 'a service with api credentials' do
        let(:method_call) { -> { Client.widget('token') } }
      end
    end
  end
end
