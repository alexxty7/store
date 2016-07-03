require 'rails_helper'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  context 'admin' do
    let(:user) { create(:user, :admin) }

    it { should be_able_to :access, :rails_admin }
    it { should be_able_to :manage, :all }
  end
end
