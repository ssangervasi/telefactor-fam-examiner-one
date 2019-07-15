# frozen_string_literal: true

module Fam
  class Family
    class Relationship
      include Comparable

      def self.from_h(input_hash)
        new(input_hash)
      end

      def initialize(child_name:, parent_name:)
        @child_name = child_name
        @parent_name = parent_name
      end

      attr_reader :child_name, :parent_name

      def to_h
        {
          child_name: @child_name,
          parent_name: @parent_name,
        }
      end

      def <=>(other)
        child_comparison = @child_name <=> other.child_name
        return child_comparison unless child_comparison.zero?

        @parent_name <=> other.parent_name
      end
    end
  end
end
