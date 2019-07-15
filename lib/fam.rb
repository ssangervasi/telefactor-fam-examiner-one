# frozen_string_literal: true

require 'fam/version'
require 'fam/cli/result'
require 'fam/file'

require 'fam/family'

module Fam
  # Includes the .success and .failure helpers which return Fam::CLI::Result objects
  #   that the CLI knows how to handle. All of the module methods should return
  #   either `success(message)` or `failure(message)`, but how they do that
  #   is up to the sourcerer.
  extend Fam::CLI::Result::Helpers
  # Includes the .read and .write helpers which will support read and writing
  #   JSON with symbol keys. These methods don't check the structure of the file,
  #   only that it is valid JSON.
  # All of the module methods should use `read(path: input_path)` to get the input family
  #   tree data, if any. Reading from a non-existant file produces an empty hash.
  # All of the "add" methods should use `write(path: output_path, json_hash: {...})`
  #   to save their output. This creates the file, or overwrites if it already exists.
  extend Fam::File::Helpers

  # These static methods are the only entrypoint that the CLI has to the application.
  #   So, as long as implementation uses the aruguments correctly and returns either
  #   `success` or `failure`, you can put whatever you want in the method bodies
  #   and in any files in the lib/fam/family directory.
  class << self
    # IMPLEMENT ME
    def add_person(
      input_path:,
      output_path:,
      person_name:
    )
      family = read_family_from_file(input_path)
      person = Fam::Family::Person.new(name: person_name)
      family.add_person(person)
      write(path: output_path, json_hash: family.to_h)
      success("Added person: #{person_name}")
    end

    # IMPLEMENT ME
    def add_parents(
      input_path:,
      output_path:,
      child_name:,
      parent_names:
    )
      family = read_family_from_file(input_path)
      child = Fam::Family::Person.new(name: child_name)
      parents = parent_names.map { |name| Fam::Family::Person.new(name: name) }
      parents.each { |parent| family.add_parent(parent: parent, child: child) }
      write(path: output_path, json_hash: family.to_h)
      success("Added #{parent_names.join(' & ')} as parents of #{child_name}")
    rescue Fam::Family::Errors::NoSuchPerson => e
      failure("No such person '#{e.message}' in family '#{input_path}'!")
    rescue Fam::Family::Errors::ExcessParents
      failure("Child '#{child_name}' can't have more than 2 parents!")
    end

    # IMPLEMENT ME
    def get_person(
      input_path:,
      person_name:
    )
      family = read_family_from_file(input_path)
      person = family.get_person(person_name)
      success(person.name)
    rescue Fam::Family::Errors::NoSuchPerson => e
      failure("No such person '#{e.message}' in family '#{input_path}'")
    end

    # IMPLEMENT ME
    def get_parents(
      input_path:,
      child_name:
    )
      family = read_family_from_file(input_path)
      child = family.get_person(child_name)
      parents = family.get_parents(child)
      success(parents.map(&:name).join("\n"))
    rescue Fam::Family::Errors::NoSuchPerson => e
      failure("No child named '#{e.message}' in family '#{input_path}'!")
    end

    def get_children(
      input_path:,
      parent_name:
    )
      family = read_family_from_file(input_path)
      parent = family.get_person(parent_name)
      children = family.get_children(parent)
      success(children.map(&:name).join("\n"))
    rescue Fam::Family::Errors::NoSuchPerson => e
      failure("No parent named '#{e.message}' in family '#{input_path}'!")
    end

    # IMPLEMENT ME
    def get_grandparents(
      input_path:,
      child_name:,
      greatness:
    )
      family = read_family_from_file(input_path)
      child = family.get_person(child_name)
      grandparents = family.get_grandparents(child, greatness: greatness)
      success(grandparents.map(&:name).join("\n"))
    rescue Fam::Family::Errors::NoSuchPerson => e
      failure("No child named '#{e.message}' in family '#{input_path}'!")
    end

    private

    def read_family_from_file(input_path)
      input_hash = read(path: input_path)
      Fam::Family.from_h(
        people: input_hash[:people] || [],
        relationships: input_hash[:relationships] || []
      )
    end
  end
end
