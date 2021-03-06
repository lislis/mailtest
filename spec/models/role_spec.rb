# == Schema Information
#
# Table name: roles
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  resource_id   :integer
#  resource_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe Role do
  let(:person) { create(:person) }

  it 'does not assign a role to a newly created user' do
    expect(person.has_role?(:admin)).to be_falsey
  end

  describe 'adding a role' do
    before { person.add_role(:admin) }

    it 'assigns the user an admin role' do
      expect(person.has_role?(:admin)).to be_truthy
    end
  end

  describe 'removing a role' do
    before do
      person.add_role(:admin)
      person.remove_role(:admin)
    end

    it 'removes the admin role from the person' do
      expect(person.has_role?(:admin)).to be_falsey
    end
  end
end
