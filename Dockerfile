FROM python:3.13-slim

# Prevents Python from buffering stdout/stderr
ENV PYTHONUNBUFFERED=1

# Install curl (needed for uv)
RUN apt-get update && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

# Install uv
RUN curl -Ls https://astral.sh/uv/install.sh | sh

# Add uv to PATH
ENV PATH="/root/.cargo/bin:$PATH"

# Set working directory
WORKDIR /app

# Copy requirements first
COPY requirements.txt .

# Install dependencies using uv
RUN uv pip install -r requirements.txt

# Copy rest of the code
COPY . .

# Run your app (change if needed)
CMD ["python", "main.py"]
