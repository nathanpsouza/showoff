# frozen_string_literal: true

module ShowoffApi
  module Client
    class Base
      attr_reader :api_address, :client_id, :client_secret

      def initialize(api_address, client_id, client_secret)
        @api_address = api_address
        @client_id = client_id
        @client_secret = client_secret
      end

      protected
        def endpoint
          raise 'You should provide one endpoint'
        end

        def parse(string)
          JSON.parse(string)
        end

        def hash_response(status, data)
          ActiveSupport::HashWithIndifferentAccess.new(
            { status: status, data: data }
          )
        end

        def handle_response(response)
          parsed_body = parse(response.body)

          if response.code == 200
            hash_response(:success, parsed_body['data'])
          else
            hash_response(:error, parsed_body['message'])
          end
        end

        def resource
          @resource ||=
            ::RestClient::Resource.new(
              "#{@api_address}/#{endpoint}", headers: headers
            )
        end

        def headers
          { 'Content-Type' => 'application/json' }
        end

        def do_post(request_body)
          resource.post(request_body.to_json)
        rescue RestClient::ExceptionWithResponse => e
          e.response
        end

        def do_get(query_string = {})
          resource.get(params: query_string)
        rescue RestClient::ExceptionWithResponse => e
          e.response
        end

        def do_put(id, request_body)
          resource["#{id}"].put(request_body.to_json)
        rescue RestClient::ExceptionWithResponse => e
          e.response
        end

        def do_delete(id)
          resource["#{id}"].delete
        rescue RestClient::ExceptionWithResponse => e
          e.response
        end
    end
  end
end
