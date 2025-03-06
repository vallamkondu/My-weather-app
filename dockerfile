# Use a lightweight Ubuntu-based image
FROM python:3.10-alpine

# Set working directory
WORKDIR /app

# Copy application files
COPY app/ /app/

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port Flask runs on
EXPOSE 5000

# Run the Flask app
CMD ["python", "main.py"]
