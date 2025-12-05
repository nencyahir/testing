require 'rails_helper'

RSpec.describe "Api::V1::Employees", type: :request do
  describe "POST /employees" do
    it "creates an employee and returns created status with json" do
      params = {
        employee: {
          full_name: "John Doe",
          job_title: "Developer",
          country: "India",
          salary: 50000
        }
      }

      post "/api/v1/employees", params: params

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["full_name"]).to eq("John Doe")
      expect(json["job_title"]).to eq("Developer")
    end
  end
end
