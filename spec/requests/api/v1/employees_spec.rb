require 'rails_helper'

RSpec.describe "Api::V1::Employees", type: :request do
  let(:employee_params) do
    {
      full_name: "John Doe",
      job_title: "Developer",
      country: "India",
      salary: 50000.56
    }
  end

  let(:employee2_params) do
    {
      full_name: "Jane Smith",
      job_title: "Designer",
      country: "USA",
      salary: 60000.75
    }
  end

  let(:employee3_params) do
    {
      full_name: "Bob Wilson",
      job_title: "Manager",
      country: "Canada",
      salary: 70000.00
    }
  end

  let!(:employee1) { Employee.create!(employee_params) }
  let!(:employee2) { Employee.create!(employee2_params) }
  let!(:employee3) { Employee.create!(employee3_params) }

  describe "GET /api/v1/employees" do
    it "returns a list of employees" do
      get "/api/v1/employees"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
      expect(json.first["full_name"]).to eq("John Doe")
    end
  end

  describe "GET /api/v1/employees/:id" do
    it "returns the employee when exists" do
      get "/api/v1/employees/#{employee1.id}"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(employee1.id)
      expect(json["full_name"]).to eq("John Doe")
    end

    it "returns not found when employee does not exist" do
      get "/api/v1/employees/99999"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/employees" do
    it "creates an employee" do
      post "/api/v1/employees", params: { employee: employee_params }

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["full_name"]).to eq("John Doe")
      expect(json["job_title"]).to eq("Developer")
      expect(json["country"]).to eq("India")
      expect(json["salary"]).to eq("50000.56")
    end
  end

  describe "DELETE /api/v1/employees/:id" do
    it "deletes the employee when exists" do
      delete "/api/v1/employees/#{employee1.id}"

      expect(response).to have_http_status(:no_content)
    end

    it "returns not found when employee does not exist" do
      delete "/api/v1/employees/99999"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /api/v1/employees/:id/salary" do
    context "when employee is from India" do
      it "calculates salary with 10% TDS deduction" do
        get "/api/v1/employees/#{employee1.id}/salary"

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["gross_salary"]).to eq("50000.56")
        expect(json["tds"]).to eq("5000.06")
        expect(json["net_salary"]).to eq("45000.5")
      end
    end

    context "when employee is from USA" do
      it "calculates salary with 12% TDS deduction" do
        get "/api/v1/employees/#{employee2.id}/salary"

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["gross_salary"]).to eq("60000.75")
        expect(json["tds"]).to eq("7200.09")
        expect(json["net_salary"]).to eq("52800.66")
      end
    end

    context "when employee is from other country" do
      it "calculates salary with no deductions" do
        get "/api/v1/employees/#{employee3.id}/salary"

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["gross_salary"]).to eq("70000.0")
        expect(json["tds"]).to eq("0.0")
        expect(json["net_salary"]).to eq("70000.0")
      end
    end

    context "when employee does not exist" do
      it "returns not found status" do
        get "/api/v1/employees/99999/salary"

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
