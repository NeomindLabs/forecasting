module Forecasting
  module Models
    class ForecastRecord < Base

      def save
        id.nil? ? create : update
      end

      def create
        forecast_client.create(self)
      end

      def update
        forecast_client.update(self)
      end

      def delete
        forecast_client.delete(self)
      end

      # It loads a new record from your Harvest account.  #
      # @return [Forecasting::Models::ForecastRecord]
      def fetch
        self.class.new(forecast_client.get(path), forecast_client: forecast_client)
      end

      # It returns the model type
      #
      # @return [String]
      def type
        self.class.name.split("::").last.downcase
      end

      def path
        raise Forecasting::MethodNotImplemented
      end

      # Retrieves an instance of the object by ID
      #
      # @param id [Integer] the id of the object to retrieve
      # @param opts [Hash] options to pass along to the `Forecasting::Client`
      #   instance
      def self.get(id, opts = {})
        client = opts[:forecast_client] || Forecasting::Client.new(**opts)
        self.new({ 'id' => id }, opts).tap do |record|
          record.attributes = client.get(record.path)
        end
      end
    end
  end
end