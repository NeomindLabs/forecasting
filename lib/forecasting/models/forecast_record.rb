module Forecasting
  module Models
    class ForecastRecord < Base
      # @return [Forecasting::Model::Client]
      attr_reader :forecast_client

      def initialize(attrs, opts = {})
        @forecast_client = opts[:forecast_client] || Forecasting::Client.new(**opts)
        super(attrs)
      end

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

      # It loads a new record from your Harvest account.
      #
      # @return [Forecasting::Models::Base]
      def fetch
        self.class.new(@forecast_client.get(path), forecast_client: @forecast_client)
      end

      # It returns the model type
      #
      # @return [String]
      def type
        self.class.name.split("::").last.downcase
      end

      # Retrieves an instance of the object by ID
      #
      # @param id [Integer] the id of the object to retrieve
      # @param opts [Hash] options to pass along to the `Forecasting::Client`
      #   instance
      def self.get(id, opts = {})
        client = opts[:forecast_client] || Forecasting::Client.new(**opts)
        self.new({ 'id' => id }, opts).fetch
      end

      protected

      # Class method to define nested resources for a record.
      #
      # It needs to be used like this:
      #
      #     class Project < ForecastRecord
      #       modeled client: Client
      #       ...
      #     end
      #
      # @param opts [Hash] key = symbol that needs to be the same as the one returned by the Harvest API. value = model class for the nested resource.
      def self.modeled(opts = {})
        opts.each do |attribute_name, model|
          attribute_name_string = attribute_name.to_s
          Forecasting::Models::ForecastRecord.send :define_method, attribute_name_string do
            @models[attribute_name_string] ||= model.new(@attributes[attribute_name_string] || {}, forecast_client: forecast_client)
          end
        end
      end
    end
  end
end