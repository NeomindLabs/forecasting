module Forecasting
  module Models
    class RemainingBudgetedHours < Base
      attributed :project_id,
                 :budget_by,
                 :budget_is_monthly,
                 :hours,
                 :response_code

      def project
        forecast_client.project(id: project_id)
      end
    end
  end
end