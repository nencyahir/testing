require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "validations" do
    it "requires full_name" do
      employee = Employee.new(full_name: nil)
      expect(employee.valid?).to be false
    end
  end
end
