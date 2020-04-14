# frozen_string_literal: true

module ShowoffApi
  module Client
    class Authentication < Base
      def endpoint
        'oauth/token'
      end

      def login(user)
        response = do_post(request_body(user))

        handle_response(response)
      end

      private
        def request_body(user)
          {
            grant_type: 'password',
            client_id: @client_id,
            client_secret: @client_secret,
            username: user[:email],
            password: user[:password]
          }
        end
    end
  end
end
