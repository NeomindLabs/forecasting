module Forecasting
  module Models
    class RepeatedAssignmentSet < ForecastRecord
      attributed :id,
                 :first_start_date,
                 :last_end_date,
                 :assignment_ids

      def path
        @attributes['id'].nil? ? "repeated_assignment_sets" : "repeated_assignment_sets/#{@attributes['id']}"
      end
      
      def assignments
        assignment_ids.map do |assignment_id|
          forecast_client.assignment(id: assignment_id)
        end
      end
    end
  end
end