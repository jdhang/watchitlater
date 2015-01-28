require 'spec_helper'

describe Movie do
  it { expect(subject).to belong_to :user }
  it { expect(subject).to validate_presence_of :title }
  it { expect(subject).to validate_uniqueness_of(:title).case_insensitive }
end
