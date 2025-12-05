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

  let!(:employee1) { Employee.create!(employee_params) }
  let!(:employee2) { Employee.create!(employee2_params) }

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
end
