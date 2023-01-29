module Forecasting
  module Models
    class Milestone < ForecastRecord
      attributed :id,
                 :name,
                 :date,
                 :project_id,
                 :updated_at,
                 :updated_by_id

      def path
        @attributes['id'].nil? ? "milestones" : "milestones/#{@attributes['id']}"
      end
      
      def project
        forecast_client.project(id: project_id)
      end
    end
  end
end