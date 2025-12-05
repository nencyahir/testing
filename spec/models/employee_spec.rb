require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "validations" do
    it "requires full_name" do
      employee = Employee.new(full_name: nil)
      expect(employee.valid?).to be false
    end
  end

    it "requires job_title" do
      employee = Employee.new(job_title: nil)
      expect(employee.valid?).to be false
    end

    it "requires country" do
      employee = Employee.new(country: nil)
      expect(employee.valid?).to be false
    end

    it "requires salary" do
      employee = Employee.new(salary: nil)
      expect(employee.valid?).to be false
    end
end
