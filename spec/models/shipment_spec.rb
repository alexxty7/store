require 'rails_helper'

RSpec.describe Shipment do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:price) }
end
