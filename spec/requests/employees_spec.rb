require 'rails_helper'

RSpec.describe "Employees API", type: :request do
  let(:valid_params) do
    {
      employee: {
        full_name: "John Doe",
        job_title: "Developer",
        country: "USA",
        salary: 60000
      }
    }
  end

  describe "POST /employees" do
    it "creates an employee" do
      post "/employees", params: valid_params
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["full_name"]).to eq("John Doe")
    end
  end

  describe "GET /employees/:id" do
    it "returns an employee" do
      employee = Employee.create!(valid_params[:employee])
      get "/employees/#{employee.id}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(employee.id)
    end
  end

  describe "PUT /employees/:id" do
    it "updates an employee" do
      employee = Employee.create!(valid_params[:employee])
      put "/employees/#{employee.id}", params: { employee: { job_title: "Manager" } }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["job_title"]).to eq("Manager")
    end
  end

  describe "DELETE /employees/:id" do
    it "deletes an employee" do
      employee = Employee.create!(valid_params[:employee])
      expect {
        delete "/employees/#{employee.id}"
      }.to change(Employee, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
