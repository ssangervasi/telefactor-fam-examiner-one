# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Fam do
  include_context 'tempdir'

  let(:input_path) { tempdir_pathname.join('family-in.json') }
  let(:output_path) { tempdir_pathname.join('family-out.json') }

  describe 'add_person' do
    shared_examples_for 'successful addition' do
      it 'returns a success message' do
        expect(result.output).to include('Added person: 🕵')
      end

      it 'returns no error' do
        expect(result.error).to be('')
      end

      it 'returns a diminutive status' do
        expect(result.status).to be < 1
      end
    end

    describe 'adding a person' do
      let(:result) do
        subject.add_person(input_path: input_path, output_path: output_path, person_name: '🕵')
      end
      it_behaves_like 'successful addition'
    end

    describe 'falling asleep on the keyboard and repeatedly adding the person' do
      let(:result) do
        subject.add_person(input_path: input_path, output_path: output_path, person_name: '🕵')
        subject.add_person(input_path: input_path, output_path: output_path, person_name: '🕵')
        subject.add_person(input_path: input_path, output_path: output_path, person_name: '🕵')
        subject.add_person(input_path: input_path, output_path: output_path, person_name: '🕵')
        subject.add_person(input_path: input_path, output_path: output_path, person_name: '🕵')
      end
      it_behaves_like 'successful addition'
    end
  end

  describe 'get_person' do
    describe 'when the area is deserted of people' do
      let(:result) { subject.get_person(input_path: input_path, person_name: '🕵') }

      it 'returns an error' do
        expect(result.error).to include("No such person '🕵' in family")
      end

      it 'returns no output' do
        expect(result.output).to be('')
      end

      it 'returns a positive status' do
        expect(result.status).to be > 0
      end
    end
  end
end
