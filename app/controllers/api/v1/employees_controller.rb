class Api::V1::EmployeesController < ApplicationController
  def index
    employees = Employee.all
    render json: employees, status: :ok
  end
#Here testing whole website
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

  def salary
    employee = Employee.find_by(id: params[:id])

    if employee
      gross_salary = employee.salary.to_f
      tds = calculate_tds(gross_salary, employee.country)
      net_salary = gross_salary - tds

      render json: {
        gross_salary: format("%.2f", gross_salary),
        tds: format("%.2f", tds),
        net_salary: format("%.2f", net_salary)
      }, status: :ok
    else
      render json: { error: "Employee not found" }, status: :not_found
    end
  end

  private

  def calculate_tds(gross_salary, country)
    case country
    when "India"
      gross_salary * 0.10
    when "USA"
      gross_salary * 0.12
    else
      0.0
    end
  end

  def employee_params
    params.require(:employee).permit(:full_name, :job_title, :country, :salary)
  end
end
