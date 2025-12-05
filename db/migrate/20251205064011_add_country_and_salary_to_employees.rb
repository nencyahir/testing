class AddCountryAndSalaryToEmployees < ActiveRecord::Migration[8.0]
  def change
    add_column :employees, :country, :string
    add_column :employees, :salary, :decimal
  end
end
