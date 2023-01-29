module Forecasting
  module Models
    # A client record from your Harvest account.
    class Client < ForecastRecord
      attributed :id,
                 :name,
                 :harvest_id,
                 :archived,
                 :updated_at,
                 :updated_by_id

      def path
        @attributes['id'].nil? ? "clients" : "clients/#{@attributes['id']}"
      end
    end
  end
end