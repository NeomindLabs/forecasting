# framework
require_relative "forecasting/version"
require_relative "forecasting/errors"
require_relative "forecasting/models/base"
require_relative "forecasting/models/forecast_record"
# forecast records
require_relative "forecasting/models/account"
require_relative "forecasting/models/address"
require_relative "forecasting/models/assignment"
require_relative "forecasting/models/card"
require_relative "forecasting/models/client"
require_relative "forecasting/models/discount"
require_relative "forecasting/models/ftux_state"
require_relative "forecasting/models/future_scheduled_hours"
require_relative "forecasting/models/milestone"
require_relative "forecasting/models/person"
require_relative "forecasting/models/placeholder"
require_relative "forecasting/models/project"
require_relative "forecasting/models/remaining_budgeted_hours"
require_relative "forecasting/models/repeated_assignment_set"
require_relative "forecasting/models/role"
require_relative "forecasting/models/subscription"
require_relative "forecasting/models/user_connection"
require_relative "forecasting/models/user"
# API client
require_relative "forecasting/client"

module Forecasting
end