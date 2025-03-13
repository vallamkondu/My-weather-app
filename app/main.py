import requests
import boto3
import os
from decimal import Decimal
from flask import Flask, render_template, request

app = Flask(__name__)

# Weatherbit API Key
API_KEY = "8403eb10edea448c94697ae6ac502186"
BASE_URL = "https://api.weatherbit.io/v2.0/current"

# AWS DynamoDB Configuration
AWS_REGION = os.getenv("AWS_DEFAULT_REGION")
TABLE_NAME = "WeatherData"

# Initialize boto3 session
session = boto3.Session()
dynamodb = session.resource("dynamodb", region_name=AWS_REGION)
table = dynamodb.Table(TABLE_NAME)

def get_weather(city):
    """Fetch weather data from Weatherbit API."""
    params = {"city": city, "key": API_KEY}
    response = requests.get(BASE_URL, params=params)

    if response.status_code == 200:
        data = response.json()
        if "data" in data and len(data["data"]) > 0:
            weather_info = data["data"][0]

            # Convert float to Decimal to avoid TypeError
            weather_data = {
                "city": weather_info["city_name"],
                "temperature": Decimal(str(weather_info["temp"])),   # ✅ Fixed here
                "description": weather_info["weather"]["description"],
                "humidity": Decimal(str(weather_info["rh"])),       # ✅ Fixed here
                "wind_speed": Decimal(str(weather_info["wind_spd"])), # ✅ Fixed here
                "icon": f"https://www.weatherbit.io/static/img/icons/{weather_info['weather']['icon']}.png"
            }

            # Store in DynamoDB
            store_weather_data(weather_data)
            return weather_data
    return None

def store_weather_data(weather_data):
    """Store weather data in DynamoDB."""
    table.put_item(Item=weather_data)

@app.route("/", methods=["GET", "POST"])
def index():
    weather_data = None
    error = None

    if request.method == "POST":
        city = request.form.get("city")
        weather_data = get_weather(city)

        if not weather_data:
            error = "City not found. Please try again."

    return render_template("index.html", weather=weather_data, error=error)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
