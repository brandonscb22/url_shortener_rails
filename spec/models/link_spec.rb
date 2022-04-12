require 'rails_helper'
RSpec.describe Link, :type => :model do
  subject {
    described_class.new(url: Faker::Internet.url,
                        url_generated: Faker::Internet.password(min_length: 8))
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a url" do
    subject.url = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a url_generated" do
    subject.url_generated = nil
    expect(subject).to_not be_valid
  end
end
