module Forecasting
  module Models
    class RemainingBudgetedHours < Base
      # @return [Forecasting::Model::Client]
      attr_reader :forecast_client

      attributed :project_id,
                 :budget_by,
                 :budget_is_monthly,
                 :hours,
                 :response_code

      def initialize(attrs, opts = {})
        @forecast_client = opts[:forecast_client] || Forecasting::Client.new(**opts)
        super(attrs)
      end

      def project
        forecast_client.project(id: project_id)
      end
    end
  end
end