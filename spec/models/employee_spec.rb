require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe "validations" do
    it "requires full_name" do
      employee = Employee.new(full_name: nil)
      expect(employee.valid?).to be false
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

    it "is valid when all attributes are present" do
      employee = Employee.new(
        full_name: "John Doe",
        job_title: "Developer",
        country: "India",
        salary: 50000
      )
      expect(employee.valid?).to be true
    end
  end
end
