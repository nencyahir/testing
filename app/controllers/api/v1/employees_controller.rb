class Api::V1::EmployeesController < ApplicationController
  def index
    employees = Employee.all
    render json: employees, status: :ok
  end

  def show
    employee = Employee.find_by(id: params[:id])

    if employee
      render json: employee, status: :ok
    else
      render json: { error: "Employee not found" }, status: :not_found
    end
  end

  def create
    employee = Employee.new(employee_params)

    if employee.save
      render json: employee, status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    employee = Employee.find_by(id: params[:id])

    if employee
      employee.destroy
      head :no_content
    else
      render json: { error: "Employee not found" }, status: :not_found
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:full_name, :job_title, :country, :salary)
  end
end
