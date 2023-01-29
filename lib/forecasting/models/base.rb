module Forecasting
  module Models
    class Base
      # @return [Hash]
      attr_accessor :attributes

      def initialize(attrs)
        @attributes = attrs.dup
        @models = {}
      end

      # It returns keys and values for all the attributes of this record.
      #
      # @return [Hash]
      def to_hash
        @attributes
      end


      # Class method to define attribute methods for accessing attributes for
      # a record
      #
      # It needs to be used like this:
      #
      #     class User < ForecastRecord
      #       attributed :id,
      #                  :title,
      #                  :first_name
      #       ...
      #     end
      #
      # @param attribute_names [Array] A list of attributes
      def self.attributed(*attribute_names)
        attribute_names.each do |attribute_name|
          define_method(attribute_name) do
            @attributes[__method__.to_s]
          end
          define_method("#{attribute_name}=") do |value|
            @attributes[__method__.to_s.chop] = value
          end
        end
      end

      # Class method to define nested resources for a record.
      #
      # It needs to be used like this:
      #
      #     class Project < Base
      #       modeled client: Client
      #       ...
      #     end
      #
      # @param opts [Hash] key = symbol that needs to be the same as the one returned by the Harvest API. value = model class for the nested resource.
      def self.modeled(opts = {})
        opts.each do |attribute_name, model|
          attribute_name_string = attribute_name.to_s
          define_method(attribute_name_string) do
            @models[attribute_name_string] ||= model.new(@attributes[attribute_name_string] || {})
          end
        end
      end
    end
  end
end