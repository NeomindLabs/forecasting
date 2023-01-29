# frozen_string_literal: true
require "http"
require "json"

class Forecasting::Client
  DEFAULT_HOST = "https://api.forecastapp.com"

  attr_accessor :access_token, :account_id, :host

  def initialize(access_token: ENV['FORECAST_ACCESS_TOKEN'],
                 account_id: ENV['FORECAST_ACCOUNT_ID'],
                 host: DEFAULT_HOST)
    @access_token = access_token
    @account_id = account_id
    @host = host
  end

  # @return [Forecasting::Models::Account]
  def account(id:)
    Forecasting::Models::Account.new(get("accounts/#{id}")["account"])
  end

  # @return [Forecasting::Models::Assignment]
  def assignment(id:)
    Forecasting::Models::Assignment.new(get("assignments/#{id}")["assignment"], forecast_client: self)
  end

  # @return [Array<Forecasting::Models::Assignment>]
  def assignments(opts = {})
    get("assignments", opts)["assignments"].map do |entry|
      Forecasting::Models::Assignment.new(entry, forecast_client: self)
    end
  end

  # @return [Forecasting::Models::Client]
  def client(id:)
    Forecasting::Models::Client.new(get("clients/#{id}")["client"], forecast_client: self)
  end

  # @return [Array<Forecasting::Models::Client>]
  def clients(opts = {})
    get("clients", opts)["clients"].map do |entry|
      Forecasting::Models::Client.new(entry, forecast_client: self)
    end
  end

  # @return [Forecasting::Models::FtuxState]
  def ftux_state
    Forecasting::Models::FtuxState.new(get("ftux_state")["ftux_state"])
  end

  # @return [Array<Forecasting::Models::FutureScheduledHours>]
  def future_scheduled_hours(opts = {})
    start_date = opts.delete(:start_date) || Time.now.strftime("%Y-%m-%d")
    get("aggregate/future_scheduled_hours/#{start_date}", opts)["future_scheduled_hours"].map do |entry|
      Forecasting::Models::FutureScheduledHours.new(entry, forecast_client: self)
    end
  end

  # @return [Forecasting::Models::Milestone]
  def milestone(id:)
    Forecasting::Models::Milestone.new(get("milestones/#{id}")["milestone"], forecast_client: self)
  end

  # @return [Array<Forecasting::Models::Milestone>]
  def milestones(opts = {})
    get("milestones", opts)["milestones"].map do |entry|
      Forecasting::Models::Milestone.new(entry, forecast_client: self)
    end
  end

  # @return [Forecasting::Models::Person]
  def person(id:)
    Forecasting::Models::Person.new(get("people/#{id}")["person"], forecast_client: self)
  end

  # @return [Array<Forecasting::Models::Person>]
  def people(opts = {})
    get("people", opts)["people"].map do |entry|
      Forecasting::Models::Person.new(entry, forecast_client: self)
    end
  end

  # @return [Forecasting::Models::Placeholder]
  def placeholder(id:)
    Forecasting::Models::Placeholder.new(get("placeholders/#{id}")["placeholder"], forecast_client: self)
  end

  # @return [Array<Forecasting::Models::Placeholder>]
  def placeholders(opts = {})
    get("placeholders", opts)["placeholders"].map do |entry|
      Forecasting::Models::Placeholder.new(entry, forecast_client: self)
    end
  end

  # @return [Forecasting::Models::Projects]
  def project(id:)
    Forecasting::Models::Project.new(get("projects/#{id}")["project"], forecast_client: self)
  end

  # @return [Array<Forecasting::Models::Project>]
  def projects(opts = {})
    get("projects", opts)["projects"].map do |entry|
      Forecasting::Models::Project.new(entry, forecast_client: self)
    end
  end

  # @return [Array<Forecasting::Models::RemainingBudgetedHours>]
  def remaining_budgeted_hours(opts = {})
    get("aggregate/remaining_budgeted_hours", opts)["remaining_budgeted_hours"].map do |entry|
      Forecasting::Models::RemainingBudgetedHours.new(entry, forecast_client: self)
    end
  end

  # @return [Forecasting::Models::RepeatedAssignmentSet]
  def repeated_assignment_set(id:)
    Forecasting::Models::RepeatedAssignmentSet.new(get("repeated_assignment_sets/#{id}")["repeated_assignment_set"], forecast_client: self)
  end

  # @return [Array<Forecasting::Models::RepeatedAssignmentSet>]
  def repeated_assignment_sets(opts = {})
    get("repeated_assignment_sets", opts)["repeated_assignment_sets"].map do |entry|
      Forecasting::Models::RepeatedAssignmentSet.new(entry, forecast_client: self)
    end
  end

  # @return [Forecasting::Models::Role]
  def role(id:)
    Forecasting::Models::Role.new(get("roles/#{id}")["role"], forecast_client: self)
  end

  # @return [Array<Forecasting::Models::Role>]
  def roles(opts = {})
    get("roles", opts)["roles"].map do |entry|
      Forecasting::Models::Role.new(entry, forecast_client: self)
    end
  end
  
  # @return [Forecasting::Models::Subscription]
  def subscription
    Forecasting::Models::Subscription.new(get("billing/subscription")["subscription"])
  end

  # @return [Forecasting::Models::UserConnection]
  def user_connections(opts = {})
    get("user_connections", opts)["user_connections"].map do |entry|
      Forecasting::Models::UserConnection.new(entry)
    end
  end

  # @return [Forecasting::Models::User]
  def whoami
    Forecasting::Models::User.new(get("whoami")["current_user"])
  end

  # Creates an `entity` in your Harvest account.
  #
  # @param entity [Harvesting::Models::Base] A new record in your Harvest account
  # @return [Harvesting::Models::Base] A subclass of `Harvesting::Models::Base` updated with the response from Harvest
  def create(entity)
    url = "#{host}/#{entity.path}"
    uri = URI(url)
    response = http_response(:post, uri, body: payload(entity))
    entity.attributes = JSON.parse(response.body)[entity.type]
    entity
  end

  # Updates an `entity` in your Harvest account.
  #
  # @param entity [Harvesting::Models::Base] An existing record in your Harvest account
  # @return [Harvesting::Models::Base] A subclass of `Harvesting::Models::Base` updated with the response from Harvest
  def update(entity)
    url = "#{host}/#{entity.path}"
    uri = URI(url)
    response = http_response(:patch, uri, body: payload(entity))
    entity.attributes = JSON.parse(response.body)[entity.type]
    entity
  end

  # It removes an `entity` from your Harvest account.
  #
  # @param entity [Harvesting::Models::Base] A record to be removed from your Harvest account
  # @return [Hash]
  # @raise [UnprocessableRequest] When HTTP response is not 200 OK
  def delete(entity)
    url = "#{host}/#{entity.path}"
    uri = URI(url)
    response = http_response(:delete, uri)
    raise Forecasting::Errors::UnprocessableRequest.new(response.to_s) unless response.code.to_i == 200

    JSON.parse(response.body)
  end

  # Performs a GET request and returned the parsed JSON as a Hash.
  #
  # @param path [String] path to be combined with `host`
  # @param opts [Hash] key/values will get passed as HTTP (GET) parameters
  # @return [Hash]
  def get(path, opts = {})
    url = "#{host}/#{path}"
    url += "?#{opts.map {|k, v| "#{k}=#{v}"}.join("&")}" if opts.any?
    uri = URI(url)
    response = http_response(:get, uri)
    JSON.parse(response.body)
  end

  private

  def payload(entity)
    {
      entity.type => entity.to_hash
    }
  end

  def http_response(method, uri, opts = {})
    response = nil

    http = HTTP["User-Agent" => "Forecasting Ruby Gem",
                "Authorization" => "Bearer #{access_token}",
                "Forecast-Account-ID" => account_id]
    params = {}
    if opts[:body]
      params[:json] = opts[:body]
    end
    response = http.send(method, uri, params)

    raise Forecasting::AuthenticationError.new(response.to_s) if auth_error?(response)
    raise Forecasting::UnprocessableRequest.new(response.to_s) if response.code.to_i == 422
    raise Forecasting::RequestNotFound.new(uri) if response.code.to_i == 404
    raise Forecasting::RateLimitExceeded.new(response.to_s) if response.code.to_i == 429

    response
  end

  def auth_error?(response)
    response.code.to_i == 403 || response.code.to_i == 401
  end
end