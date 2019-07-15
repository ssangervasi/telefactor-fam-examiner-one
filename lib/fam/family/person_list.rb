# frozen_string_literal: true

module Fam
  class Family
    class PersonList
      def initialize(people:)
        raise NoMethodError unless people.is_a? Array

        @people_by_name = {}
        people.each(&method(:insert_person))
      end

      def to_a
        @people_by_name.values
      end

      def includes_name?(name)
        @people_by_name.keys.include?(name)
      end

      def insert_person(person)
        raise NoMethodError unless person.is_a? Fam::Family::Person

        @people_by_name[person.name] = person
      end

      def get_person_by_name(name)
        @people_by_name[name]
      end
    end
  end
end
