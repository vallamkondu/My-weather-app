provider "aws" {
  region = "eu-north-1"
}

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
}
