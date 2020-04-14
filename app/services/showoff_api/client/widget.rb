# frozen_string_literal: true

module ShowoffApi
  module Client
    class Widget < Base
      def initialize(token, api_address, client_id, client_secret)
        super(api_address, client_id, client_secret)
        @token = token
      end

      def endpoint
        'api/v1/widgets'
      end

      def widgets(term = nil)
        response = do_get

        handle_response(response)
      end

      def save(widget)
        response = do_post(request_body(widget))

        handle_response(response)
      end

      def delete(id)
        response = do_delete(id)

        handle_response(response)
      end

      def update(id, widget)
        response = do_put(id, request_body(widget))

        handle_response(response)
      end

      def headers
        super.merge({ 'Authorization' => "Bearer #{@token}" })
      end

      private
        def request_body(widget)
          {
            widget: widget.to_hash
          }
        end
    end
  end
end
