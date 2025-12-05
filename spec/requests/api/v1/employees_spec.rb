require 'rails_helper'

RSpec.describe "Api::V1::Employees", type: :request do
  let(:employee) do
    {
      full_name: "John Doe",
      job_title: "Developer",
      country: "India",
      salary: 50000.56
    }
  end

  let(:employee2) do
    {
      full_name: "Jane Smith",
      job_title: "Designer",
      country: "USA",
      salary: 60000.75
    }
  end

  let!(:created_employee1) { Employee.create!(employee) }
  let!(:created_employee2) { Employee.create!(employee2) }

  describe "GET /api/v1/employees" do
    context "when employees exist" do
      it "returns a list of employees with ok status" do
        get "/api/v1/employees"

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json).to be_an(Array)
        expect(json.length).to eq(2)
        expect(json.first["full_name"]).to eq("John Doe")
        expect(json.first["job_title"]).to eq("Developer")
        expect(json.first["country"]).to eq("India")
        expect(json.first["salary"]).to eq("50000.56")
      end
    end

    context "when no employees exist" do
      it "returns an empty array" do
        get "/api/v1/employees"

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json).to be_an(Array)
        expect(json).to be_empty
      end
    end
  end

  describe "POST /api/v1/employees" do
    it "creates an employee and returns created status with json" do
      post "/api/v1/employees", params: { employee: employee }

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["full_name"]).to eq("John Doe")
      expect(json["job_title"]).to eq("Developer")
      expect(json["country"]).to eq("India")
      expect(json["salary"]).to eq("50000.56")
    end
  end
end
