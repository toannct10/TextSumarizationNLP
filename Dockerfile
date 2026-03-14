FROM python:3.10-slim

RUN apt-get update && apt-get install -y --no-install-recommends awscli \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt /app/

RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir --upgrade accelerate \
    && pip uninstall -y transformers accelerate \
    && pip install --no-cache-dir transformers accelerate

COPY . /app

CMD ["python3", "app.py"]
