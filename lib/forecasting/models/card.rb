module Forecasting
  module Models
    class Card < Base
      attributed :brand,
                 :last_four,
                 :expiry_month,
                 :expiry_year
    end
  end
end