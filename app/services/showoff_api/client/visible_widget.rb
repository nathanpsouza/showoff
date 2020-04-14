# frozen_string_literal: true

module ShowoffApi
  module Client
    class VisibleWidget < Base
      def endpoint
        'api/v1/widgets/visible'
      end

      def visible(term = nil)
        response = do_get(query_string(term))

        handle_response(response)
      end

      private
        def query_string(term)
          query = {
            client_id: @client_id,
            client_secret: @client_secret
          }

          query[:term] = term if term

          query
        end
    end
  end
end
