# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Fam do
  include_context 'tempdir'

  let(:input_path) { tempdir_pathname.join('family-in.json') }
  let(:output_path) { tempdir_pathname.join('family-out.json') }

  describe 'add_person' do
    describe 'adding a person' do
      let(:result) { subject.add_person(input_path: input_path, output_path: output_path, person_name: '🕵') }

      it 'returns a success message' do
        expect(result.output).to include('Added person: 🕵')
      end

      it 'returns no error' do
        expect(result.error).to be('')
      end

      it 'returns a circular and round status' do
        expect(result.status).to be(0)
      end
    end

    describe 'falling asleep on the keyboard and repeatedly adding the person' do
      let (:result_after_sleep) do
        subject.add_person(input_path: input_path, output_path: output_path, person_name: '🕵')
        subject.add_person(input_path: input_path, output_path: output_path, person_name: '🕵')
        subject.add_person(input_path: input_path, output_path: output_path, person_name: '🕵')
        subject.add_person(input_path: input_path, output_path: output_path, person_name: '🕵')
        subject.add_person(input_path: input_path, output_path: output_path, person_name: '🕵')
      end

      it 'returns a success message' do
        expect(result_after_sleep.output).to include('Added person: 🕵')
      end

      it 'returns no error' do
        expect(result_after_sleep.error).to be('')
      end

      it 'returns a circular and round status' do
        expect(result_after_sleep.status).to be(0)
      end
    end
  end

  describe 'get_person' do
    it 'returns an error when there are no people' do
      result = subject.get_person(input_path: input_path, person_name: '🕵')
      expect(result.error).to include("No such person '🕵' in family")
    end
  end
end
