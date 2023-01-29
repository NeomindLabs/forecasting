module Forecasting
  module Models
    class UserConnection < Base
      attributed :id,
                 :person_id,
                 :last_active_at

      def person
        forecast_client.person(id: person_id)
      end
    end
  end
end