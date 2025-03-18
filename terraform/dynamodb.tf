resource "aws_dynamodb_table" "weather_data" {
  name         = "WeatherData"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "city"

  attribute {
    name = "city"
    type = "S"
  }

  tags = {
    Name = "WeatherDataTable"
  }

  lifecycle {
    prevent_destroy = false  # Allows deletion if necessary
    ignore_changes  = [read_capacity, write_capacity]  # Ignores capacity changes
  }
}