# frozen_string_literal: true

module Fam
  class Family
    class RelationshipList
      def initialize(relationships:)
        raise NoMethodError unless relationships.is_a? Array

        @relationships_by_child = Hash.new { |hash, key| hash[key] = [] }
        @relationships_by_parent = Hash.new { |hash, key| hash[key] = [] }
        relationships.each do |relationship|
          add_relationship(
            child_name: relationship.child_name,
            parent_name: relationship.parent_name
          )
        end
      end

      def to_a
        @relationships_by_child.values.flatten
      end

      def add_relationship(child_name:, parent_name:)
        new_relationship = Fam::Family::Relationship.new(
          child_name: child_name,
          parent_name: parent_name
        )
        @relationships_by_child[child_name] << new_relationship
        @relationships_by_parent[parent_name] << new_relationship
      end

      def include?(child:, parent:)
        !@relationships_by_child[child.name].detect { |rel| rel.parent_name == parent.name }.nil?
      end

      def get_parent_names(child_name)
        @relationships_by_child[child_name].map(&:parent_name)
      end

      def get_child_names(parent_name)
        @relationships_by_parent[parent_name].map(&:child_name)
      end

      def get_grandparent_names(person, greatness: 0)
        elder_list = get_parent_names(person)
        while greatness >= 0
          elder_list = elder_list.map { |curr_person| get_parent_names(curr_person) }.flatten
          greatness -= 1
        end
        elder_list
      end
    end
  end
end
