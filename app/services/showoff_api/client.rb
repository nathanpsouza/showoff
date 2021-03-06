# frozen_string_literal: true

module ShowoffApi
  module Client
    def self.user(token=nil)
      verify_api_credentials
      User.new(token, *default_attributes)
    end

    def self.authentication
      verify_api_credentials
      Authentication.new(*default_attributes)
    end

    def self.visible_widget
      verify_api_credentials
      VisibleWidget.new(*default_attributes)
    end

    def self.widget(token)
      verify_api_credentials
      Widget.new(token, *default_attributes)
    end

    def self.verify_api_credentials
      %w[API_ADDRESS CLIENT_ID CLIENT_SECRET].each do |env|
        unless ENV.key?(env)
          raise "You must provide #{env} environment variable"
        end
      end
    end

    def self.default_attributes
      [ENV['API_ADDRESS'], ENV['CLIENT_ID'], ENV['CLIENT_SECRET']]
    end
  end
end
