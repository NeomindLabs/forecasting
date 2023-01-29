module Forecasting
  module Models
    class Account < Base
      attributed :id,
                 :name,
                 :weekly_capacity,
                 :harvest_subdomain,
                 :harvest_link,
                 :harvest_name,
                 :weekends_enabled,
                 :created_at

      def color_labels
        attributes["color_labels"].map do |entry|
          ColorLabel.new(entry)
        end
      end
    end
  end
end