require 'spec_helper'

RSpec.describe Forecasting::Client do

  describe "#initialize" do
    context "when parameters are valid" do
      it "builds a client with a token and account" do
        Forecasting::Client.new(access_token: "foo", account_id: "bar")
      end
    end
  end
end