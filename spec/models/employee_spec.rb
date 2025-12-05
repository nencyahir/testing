require "rails_helper"

RSpec.describe Employee, type: :model do
  subject do
    described_class.new(
      full_name: "John Doe",
      job_title: "Developer",
      country: "India",
      salary: 50000
    )
  end

  describe "validations" do
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:job_title) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:salary) }

    it "is valid with all required attributes" do
      expect(subject).to be_valid
    end
  end
end
