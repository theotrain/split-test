require 'spec_helper'

describe Item do
  it {should belong_to(:group)}
  it {should have_many(:votes)}
end