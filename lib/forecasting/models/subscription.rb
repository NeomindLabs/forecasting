module Forecasting
  module Models
    class Subscription < Base
      attributed :id,
                 :next_billing_date,
                 :days_until_next_billing_date,
                 :amount,
                 :amount_per_person,
                 :receipt_recipient,
                 :status,
                 :purchase_people,
                 :interval,
                 :paid_by_invoice,
                 :placeholder_limit,
                 :invoiced,
                 :days_until_due,
                 :balance,
                 :sales_tax_exempt,
                 :sales_tax_percentage

      modeled address: Address, card: Card, discounts: Discount
    end
  end
end