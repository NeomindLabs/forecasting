module Forecasting
  module Models
    class Placeholder < ForecastRecord
      attributed :id,
                 :name,
                 :archived,
                 :roles,
                 :updated_at,
                 :updated_by_id

      def path
        @attributes['id'].nil? ? "placeholders" : "placeholders/#{@attributes['id']}"
      end
    end
  end
end