module Stew
  module FetchableAttributes
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def attr_reader_fetchable(*attributes)
        attributes.each{|attr| create_attr_method(attr)}
      end

      private

      def create_attr_method(attr)
        define_method(attr) do
          fetch if instance_variable_get("@#{attr}").nil?
          instance_variable_get("@#{attr}")
        end
      end
    end
  end
end