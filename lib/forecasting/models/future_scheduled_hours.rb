module Forecasting
  module Models
    class FutureScheduledHours < Base
      attributed :project_id,
                 :person_id,
                 :placeholder_id,
                 :allocation

      def project
        forecast_client.project(id: project_id)
      end

      def person
        forecast_client.person(id: person_id)
      end

      def placeholder
        forecast_client.placeholder(id: placeholder_id)
      end
    end
  end
end