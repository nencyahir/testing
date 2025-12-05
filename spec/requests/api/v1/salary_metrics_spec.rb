require 'rails_helper'

RSpec.describe "Api::V1::Salaries", type: :request do
  let!(:employee1) { Employee.create!(full_name: "John Doe", job_title: "Developer", country: "India", salary: 50000.00) }
  let!(:employee2) { Employee.create!(full_name: "Jane Smith", job_title: "Developer", country: "India", salary: 60000.00) }
  let!(:employee3) { Employee.create!(full_name: "Bob Wilson", job_title: "Designer", country: "USA", salary: 70000.00) }
  let!(:employee4) { Employee.create!(full_name: "Alice Brown", job_title: "Designer", country: "USA", salary: 80000.00) }

  describe "GET /api/v1/salaries/country" do
    it "returns min, max, and average salary for India" do
      get "/api/v1/salaries/country", params: { country: "India" }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["country"]).to eq("India")
      expect(json["min_salary"]).to eq("50000.00")
      expect(json["max_salary"]).to eq("60000.00")
      expect(json["average_salary"]).to eq("55000.00")
    end
  end

  describe "GET /api/v1/salaries/job_title" do
    it "returns average salary for job title" do
      get "/api/v1/salaries/job_title", params: { title: "Designer" }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["job_title"]).to eq("Designer")
      expect(json["average_salary"]).to eq("75000.00")
    end
  end
end
