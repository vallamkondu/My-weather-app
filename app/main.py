import requests
from flask import Flask, render_template, request

app = Flask(__name__)

# Weatherbit API Key
API_KEY = "8403eb10edea448c94697ae6ac502186"
BASE_URL = "https://api.weatherbit.io/v2.0/current"

def get_weather(city):
    """Fetch weather data from Weatherbit API."""
    params = {"city": city, "key": API_KEY}
    response = requests.get(BASE_URL, params=params)

    if response.status_code == 200:
        data = response.json()
        if "data" in data and len(data["data"]) > 0:
            weather_info = data["data"][0]
            return {
                "city": weather_info["city_name"],
                "temperature": weather_info["temp"],
                "description": weather_info["weather"]["description"],
                "humidity": weather_info["rh"],
                "wind_speed": weather_info["wind_spd"],
                "icon": f"https://www.weatherbit.io/static/img/icons/{weather_info['weather']['icon']}.png"
            }
        else:
            return None
    else:
        return None

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
