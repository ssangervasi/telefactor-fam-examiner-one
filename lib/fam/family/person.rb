# frozen_string_literal: true

module Fam
  class Family
    class Person
      include Comparable

      def self.from_h(input_hash)
        new(name: input_hash[:name])
      end

      def initialize(name:)
        @name = name
      end

      attr_reader :name

      def to_h
        { name: @name }
      end

      def <=>(other)
        @name <=> other.name
      end
    end
  end
end
