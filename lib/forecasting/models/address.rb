module Forecasting
  module Models
    class Address < Base
      attributed :line_1,
                 :line_2,
                 :city,
                 :state,
                 :postal_code,
                 :country
    end
  end
end