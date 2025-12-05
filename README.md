# Salary API

A RESTful API for managing employees and calculating salary metrics.

## Setup

1. Install dependencies:
   ```bash
   bundle install
   ```

2. Setup database:
   ```bash
   rails db:create
   rails db:migrate
   ```

3. Start the server:
   ```bash
   rails server
   ```

## API Endpoints

### Employees

- `GET /api/v1/employees` - List all employees
- `GET /api/v1/employees/:id` - Show an employee
- `POST /api/v1/employees` - Create an employee
- `DELETE /api/v1/employees/:id` - Delete an employee
- `GET /api/v1/employees/:id/salary` - Calculate salary with deductions

### Salary Metrics

- `GET /api/v1/salaries/country?country=India` - Get salary metrics by country
- `GET /api/v1/salaries/job_title?title=Developer` - Get average salary by job title

## Testing

Run the test suite:
```bash
bundle exec rspec
```

Run RuboCop:
```bash
bin/rubocop
```

## Tech Stack

- Ruby on Rails 8.0
- SQLite3
- RSpec
- RuboCop
