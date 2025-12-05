class Api::V1::SalariesController < ApplicationController
  def country
    employees = Employee.where(country: params[:country])

    if employees.any?
      salaries = employees.pluck(:salary).map(&:to_f)
      render json: {
        country: params[:country],
        min_salary: format("%.2f", salaries.min),
        max_salary: format("%.2f", salaries.max),
        average_salary: format("%.2f", salaries.sum / salaries.length)
      }, status: :ok
    else
      render json: {
        country: params[:country],
        min_salary: nil,
        max_salary: nil,
        average_salary: nil
      }, status: :ok
    end
  end

  def job_title
    employees = Employee.where(job_title: params[:title])

    if employees.any?
      salaries = employees.pluck(:salary).map(&:to_f)
      average = salaries.sum / salaries.length
      render json: {
        job_title: params[:title],
        average_salary: format("%.2f", average)
      }, status: :ok
    else
      render json: {
        job_title: params[:title],
        average_salary: nil
      }, status: :ok
    end
  end
end
