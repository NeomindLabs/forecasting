module Forecasting
  module Models
    class Discount < Base
      attributed :monthly_percentage,
                 :yearly_percentage
    end
  end
end