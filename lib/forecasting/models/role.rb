module Forecasting
  module Models
    class Role < ForecastRecord
      attributed :id,
                 :name,
                 :placeholder_ids,
                 :person_ids,
                 :harvest_role_id

      def path
        @attributes['id'].nil? ? "roles" : "roles/#{@attributes['id']}"
      end
      
      def placeholders
        placeholder_ids.map do |placeholder_id|
          forecast_client.placeholder(id: placeholder_id)
        end
      end

      def people
        person_ids.map do |person_id|
          forecast_client.person(id: person_id)
        end
      end
    end
  end
end