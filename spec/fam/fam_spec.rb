# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Fam do
  include_context 'tempdir'

  let(:input_path) { tempdir_pathname.join('family-in.json') }
  let(:output_path) { tempdir_pathname.join('family-out.json') }

  SUCCESS_CODE = 0
  ERROR_CODE = 1

  describe 'add_person' do
    shared_examples_for 'successful addition' do
      it 'returns a success message' do
        expect(result.output).to include('Added person: 🕵')
      end

      it 'returns no error' do
        expect(result.error).to eq('')
      end

      it 'returns a SUCCESS_CODE status' do
        expect(result.status).to be SUCCESS_CODE
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
      let(:result) { subject.get_person(input_path: output_path, person_name: '🕵') }

      it 'returns an error' do
        expect(result.error).to include("No such person '🕵' in family")
      end

      it 'returns an ERROR_CODE status' do
        expect(result.status).to be ERROR_CODE
      end
    end

    describe 'when the person exists' do
      let(:result) do
        subject.add_person(input_path: input_path, output_path: output_path, person_name: '🕵')
        subject.get_person(input_path: output_path, person_name: '🕵')
      end

      it 'returns no error' do
        expect(result.error).to eq('')
      end

      it 'returns the person' do
        expect(result.output).to eq('🕵')
      end

      it 'returns a SUCCESS_CODE status' do
        expect(result.status).to be SUCCESS_CODE
      end
    end
  end

  describe 'add_parents' do
    describe 'when no one exists' do
      let(:result) do
        subject.add_parents(
          input_path: input_path,
          output_path: output_path,
          child_name: '🕵',
          parent_names: ['🔎', '🔍']
        )
      end

      it 'returns an error for one of the so-called people involved' do
        expect(result.error).to include("No such person '🔎' in family")
      end

      it 'returns no output' do
        expect(result.output).to eq('')
      end

      it 'returns an ERROR_CODE status' do
        expect(result.status).to be ERROR_CODE
      end
    end

    describe 'when the child does not exist' do
      let(:result) do
        subject.add_person(
          input_path: input_path,
          output_path: input_path,
          person_name: '🔎'
        )
        subject.add_person(
          input_path: input_path,
          output_path: input_path,
          person_name: '🔍'
        )
        subject.add_parents(
          input_path: input_path,
          output_path: output_path,
          child_name: '🕵',
          parent_names: ['🔎', '🔍']
        )
      end

      it 'returns an error for the child being AWOL' do
        expect(result.error).to include("No such person '🕵' in family")
      end

      it 'returns no output' do
        expect(result.output).to eq('')
      end

      it 'returns an ERROR_CODE status' do
        expect(result.status).to be ERROR_CODE
      end
    end

    describe 'when the parents do not exist' do
      let(:result) do
        subject.add_person(
          input_path: input_path, output_path: input_path, person_name: '🕵'
        )
        subject.add_parents(
          input_path: input_path,
          output_path: output_path, child_name: '🕵', parent_names: ['🔎', '🔍']
        )
      end

      it 'returns an error for the child being AWOL' do
        expect(result.error).to include("No such person '🔎' in family")
      end

      it 'returns no output' do
        expect(result.output).to eq('')
      end

      it 'returns an ERROR_CODE status' do
        expect(result.status).to be ERROR_CODE
      end
    end

    describe 'when everyone exists' do
      let(:result) do
        subject.add_person(
          input_path: input_path, output_path: input_path, person_name: '🔎'
        )
        subject.add_person(
          input_path: input_path, output_path: input_path, person_name: '🔍'
        )
        subject.add_person(
          input_path: input_path, output_path: input_path, person_name: '🕵'
        )
        subject.add_parents(
          input_path: input_path,
          output_path: output_path, child_name: '🕵', parent_names: ['🔎', '🔍']
        )
      end

      it 'returns no error' do
        expect(result.error).to eq('')
      end

      it 'returns a success message about the adoption' do
        expect(result.output).to eq('Added 🔎 & 🔍 as parents of 🕵')
      end

      it 'returns a SUCCESS_CODE status' do
        expect(result.status).to be SUCCESS_CODE
      end
    end

    describe 'narcissism' do
      let(:result) do
        subject.add_person(
          input_path: input_path,
          output_path: input_path, person_name: '🕵'
        )
        subject.add_parents(
          input_path: input_path,
          output_path: output_path, child_name: '🕵', parent_names: ['🕵', '🕵']
        )
      end

      it 'is a valid means of reproduction' do
        expect(result.status).to be SUCCESS_CODE
      end
    end

    describe 'parthenogenesis' do
      let(:result) do
        subject.add_person(
          input_path: input_path,
          output_path: input_path, person_name: '🕵'
        )
        subject.add_parents(
          input_path: input_path,
          output_path: output_path, child_name: '🕵', parent_names: ['🕵']
        )
      end

      it 'is a valid means of reproduction' do
        expect(result.status).to be SUCCESS_CODE
      end
    end

    describe 'spontaneous generation' do
      let(:result) do
        subject.add_person(
          input_path: input_path,
          output_path: input_path, person_name: '🕵'
        )
        subject.add_parents(
          input_path: input_path,
          output_path: output_path, child_name: '🕵', parent_names: []
        )
      end

      it 'is a valid means of reproduction' do
        expect(result.status).to be SUCCESS_CODE
      end
    end

    describe 'time travel' do
      before do
        subject.add_person(
          input_path: input_path,
          output_path: input_path, person_name: '🕵'
        )
        subject.add_person(
          input_path: input_path,
          output_path: input_path, person_name: '🔎'
        )
      end

      let(:result1) do
        subject.add_parents(
          input_path: input_path,
          output_path: output_path, child_name: '🕵', parent_names: ['🔎']
        )
      end

      let(:result2) do
        subject.add_parents(
          input_path: input_path,
          output_path: output_path, child_name: '🔎', parent_names: ['🕵']
        )
      end

      it 'is a valid means of reproduction' do
        expect(result1.status).to be SUCCESS_CODE
        expect(result2.status).to be SUCCESS_CODE
      end
    end
  end
end
