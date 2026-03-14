FROM python:3.10-slim

# Install AWS CLI nhẹ nhàng và dọn cache
RUN apt-get update && apt-get install -y --no-install-recommends awscli \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy only requirements first → cache tốt hơn
COPY requirements.txt /app/

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir --upgrade accelerate \
    && pip uninstall -y transformers accelerate \
    && pip install --no-cache-dir transformers accelerate

# Copy rest of the code
COPY . /app

CMD ["python3", "app.py"]
