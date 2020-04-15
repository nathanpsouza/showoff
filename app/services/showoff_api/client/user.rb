# frozen_string_literal: true

module ShowoffApi
  module Client
    class User < Base
      def initialize(token, api_address, client_id, client_secret)
        super(api_address, client_id, client_secret)
        @token = token
      end

      def endpoint
        'api/v1/users'
      end

      def save(user)
        response = do_post(request_body(user))

        handle_response(response)
      end

      def user(id)
        response = do_single_get(id)

        handle_response(response)
      end

      def widgets_for(id, term=nil)
        query = {
          client_id: @client_id,
          client_secret: @client_secret
        }

        query[:term] = term if term

        response = do_single_get("/#{id}/widgets/", query)

        handle_response(response)
      end

      def me
        user('me')
      end

      def update(user)
        response = do_put('me', request_body(user))

        handle_response(response)
      end

      def headers
        headers = super
        headers.merge!({ 'Authorization' => "Bearer #{@token}" }) if @token
        headers
      end

      private
        def request_body(user)
          {
            user: user.to_hash,
            client_id: @client_id,
            client_secret: @client_secret
          }
        end
    end
  end
end
