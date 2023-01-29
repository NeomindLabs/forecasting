module Forecasting
  module Models
    class Person < ForecastRecord
      attributed :id,
                 :first_name,
                 :last_name,
                 :email,
                 :login,
                 :admin,
                 :archived,
                 :subscribed,
                 :avatar_url,
                 :roles,
                 :updated_at,
                 :updated_by_id,
                 :harvest_user_id,
                 :weekly_capacity,
                 :working_days,
                 :color_blind,
                 :personal_feed_token_id

      def path
        @attributes['id'].nil? ? "people" : "people/#{@attributes['id']}"
      end
    end
  end
end