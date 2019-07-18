# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Fam do
  include_context 'tempdir'

  let(:input_path) { tempdir_pathname.join('family-in.json') }
  let(:output_path) { tempdir_pathname.join('family-out.json') }

  SUCCESS_CODE = 0
  ERROR_CODE = 1

  describe 'dev apology' do
    it 'Sorry, rspec is new to me and I did not have my laptop for half the week. \
        Please forgive weirdness!' do
      expect(true).to be true
    end
  end

  describe 'add_person' do
    describe 'adding a person' do
      let(:result) do
        subject.add_person(input_path: input_path, output_path: input_path, person_name: '🕵')
      end

      it 'returns a success message' do
        expect(result.output).to include('Added person: 🕵')
      end

      it 'returns a SUCCESS_CODE status' do
        expect(result.status).to be SUCCESS_CODE
      end
    end

    describe 'falling asleep on the keyboard and repeatedly adding the person' do
      it 'raises a DuplicatePerson error' do
        expect do
          subject.add_person(input_path: input_path, output_path: input_path, person_name: '🕵')
          subject.add_person(input_path: input_path, output_path: input_path, person_name: '🕵')
        end.to raise_error(Fam::Family::Errors::DuplicatePerson)
      end
    end
  end

  describe 'get_person' do
    describe 'when the area is deserted of people' do
      let(:result) { subject.get_person(input_path: input_path, person_name: '🕵') }

      it 'returns an error' do
        expect(result.error).to include("No such person '🕵' in family")
      end

      it 'returns an ERROR_CODE status' do
        expect(result.status).to be ERROR_CODE
      end
    end

    describe 'when the person exists' do
      let(:result) do
        subject.add_person(input_path: input_path, output_path: input_path, person_name: '🕵')
        subject.get_person(input_path: input_path, person_name: '🕵')
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
          output_path: input_path,
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
          output_path: input_path,
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
          output_path: input_path, child_name: '🕵', parent_names: ['🔎', '🔍']
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
          output_path: input_path, child_name: '🕵', parent_names: ['🔎', '🔍']
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

    describe 'too many parents' do
      let(:result) do
        subject.add_person(
          input_path: input_path, output_path: input_path, person_name: '🔎'
        )
        subject.add_person(
          input_path: input_path, output_path: input_path, person_name: '🔍'
        )
        subject.add_person(
          input_path: input_path, output_path: input_path, person_name: '👣'
        )
        subject.add_person(
          input_path: input_path, output_path: input_path, person_name: '🕵'
        )
        subject.add_parents(
          input_path: input_path,
          output_path: input_path, child_name: '🕵', parent_names: ['🔎', '🔍', '👣']
        )
      end

      it 'returns an error for third gene-donor (no non-traditional \
          adoptions/mitochrondria donations)' do
        expect(result.status).to be ERROR_CODE
      end

      it 'returns an error message about the adoption' do
        expect(result.error).to eq("Child '🕵' can't have more than 2 parents!")
      end
    end
  end

  describe 'families' do
    describe 'nuclear' do
      before do
        subject.add_person(
          input_path: input_path, output_path: input_path, person_name: 'Grandfather A'
        )
        subject.add_person(
          input_path: input_path, output_path: input_path, person_name: 'Grandmother A'
        )
        subject.add_person(
          input_path: input_path, output_path: input_path, person_name: 'A'
        )
        subject.add_parents(
          input_path: input_path,
          output_path: input_path,
          child_name: 'A',
          parent_names: ['Grandfather A', 'Grandmother A']
        )
      end

      it 'returns parents of father correctly' do
        result = subject.get_parents(input_path: input_path, child_name: 'A')
        expect(result.status).to be SUCCESS_CODE
        expect(result.output).to eq "Grandfather A\nGrandmother A"
      end
    end

    describe 'narcissism' do
      let(:create_family) do
        subject.add_person(
          input_path: input_path,
          output_path: input_path, person_name: '🕵'
        )
        subject.add_parents(
          input_path: input_path,
          output_path: input_path, child_name: '🕵', parent_names: ['🕵', '🕵']
        )
      end

      it 'is a valid means of reproduction' do
        expect(create_family.status).to be SUCCESS_CODE
      end
    end

    describe 'parthenogenesis' do
      let(:create_family) do
        subject.add_person(
          input_path: input_path,
          output_path: input_path, person_name: '🕵'
        )
        subject.add_parents(
          input_path: input_path,
          output_path: input_path, child_name: '🕵', parent_names: ['🕵']
        )
      end

      it 'is a valid means of reproduction' do
        expect(create_family.status).to be SUCCESS_CODE
      end
    end

    describe 'spontaneous generation' do
      let(:create_family) do
        subject.add_person(
          input_path: input_path,
          output_path: input_path, person_name: '🕵'
        )
        subject.add_parents(
          input_path: input_path,
          output_path: input_path, child_name: '🕵', parent_names: []
        )
      end

      it 'is a valid means of reproduction' do
        expect(create_family.status).to be SUCCESS_CODE
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

      let(:create_family1) do
        subject.add_parents(
          input_path: input_path,
          output_path: input_path, child_name: '🕵', parent_names: ['🔎']
        )
      end

      let(:create_family2) do
        subject.add_parents(
          input_path: input_path,
          output_path: input_path, child_name: '🔎', parent_names: ['🕵']
        )
      end

      it 'is a valid means of reproduction' do
        expect(create_family1.status).to be SUCCESS_CODE
        expect(create_family2.status).to be SUCCESS_CODE
      end
    end
  end
end
