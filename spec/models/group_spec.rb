require 'spec_helper'

describe Group do
  it { should belong_to(:user) }
  it { should have_many(:items)}
  it { should belong_to(:category)}
end