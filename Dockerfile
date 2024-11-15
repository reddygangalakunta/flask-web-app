# Dockerfile
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the application code and requirements
COPY . /app

# Install dependencies
RUN pip install -r requirements.txt

# Expose the port the app will run on
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]

