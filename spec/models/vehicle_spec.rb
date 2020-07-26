require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  it { is_expected.to validate_uniqueness_of(:title).scoped_to(:web_source, :location) }
end
