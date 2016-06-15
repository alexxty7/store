require 'rails_helper'

RSpec.describe CreditCard do
  it { is_expected.to validate_presence_of(:number) }
  it { is_expected.to validate_presence_of(:cvv) }
  it { is_expected.to validate_presence_of(:month) }
  it { is_expected.to validate_presence_of(:year) }
end
