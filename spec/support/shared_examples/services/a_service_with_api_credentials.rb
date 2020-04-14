# frozen_string_literal: true

RSpec.shared_examples 'a service with api credentials' do
  let(:method_call) { -> { raise 'You must provide a method call' } }

  before do
    ENV['API_ADDRESS'] = 'https://foo'
    ENV['CLIENT_ID'] = 'id'
    ENV['CLIENT_SECRET'] = 'secret'
  end

  it 'Throw exception if ENV[\'API_ADDRESS\'] is not set' do
    ENV.delete('API_ADDRESS')
    message = 'You must provide API_ADDRESS environment variable'

    expect {
      method_call.call
    }.to raise_error(RuntimeError, message)
  end

  it 'Throw exception if ENV[\'CLIENT_ID\'] is not set' do
    ENV.delete('CLIENT_ID')
    message = 'You must provide CLIENT_ID environment variable'

    expect {
      method_call.call
    }.to raise_error(RuntimeError, message)
  end

  it 'Throw exception if ENV[\'CLIENT_SECRET\'] is not set' do
    ENV.delete('CLIENT_SECRET')
    message = 'You must provide CLIENT_SECRET environment variable'

    expect {
      method_call.call
    }.to raise_error(RuntimeError, message)
  end
end
