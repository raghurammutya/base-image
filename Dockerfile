FROM python:3.10-slim-bookworm

# Install system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential gcc libpq-dev libffi-dev libxml2-dev libxslt1-dev \
    libjpeg-dev libfreetype6-dev libpng-dev liblapack-dev gfortran \
    curl git procps net-tools bash \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy and install Python dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r /app/requirements.txt

# Expose debug port
EXPOSE 5678