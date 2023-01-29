module Forecasting
  module Models
    # A project record from your Harvest account.
    class Project < ForecastRecord
      attributed :id,
                 :name,
                 :code,
                 :color,
                 :notes,
                 :start_date,
                 :end_date,
                 :harvest_id,
                 :archived,
                 :updated_at,
                 :updated_by_id,
                 :client_id,
                 :tags

      def path
        @attributes['id'].nil? ? "projects" : "projects/#{@attributes['id']}"
      end
      
      def client
        forecast_client.client(id: client_id)
      end
    end
  end
end