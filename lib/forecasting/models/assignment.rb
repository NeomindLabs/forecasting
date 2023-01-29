module Forecasting
  module Models
    class Assignment < ForecastRecord
      attributed :id,
                 :start_date,
                 :end_date,
                 :allocation,
                 :notes,
                 :project_id,
                 :person_id,
                 :placeholder_id,
                 :repeated_assignment_set_id,
                 :active_on_days_off,
                 :updated_at,
                 :updated_by_id

      def path
        @attributes['id'].nil? ? "milestones" : "milestones/#{@attributes['id']}"
      end
      
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