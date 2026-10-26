FROM python:3.13-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    chromium chromium-driver \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV BROWSER=chromium

ENTRYPOINT ["robot"]
CMD ["--outputdir", "results", "tests/api/"]

# Usage:
#   docker build -t rf-enterprise .
#   docker run --rm -v $(pwd)/results:/app/results rf-enterprise
#   docker run --rm -v $(pwd)/results:/app/results rf-enterprise --include api tests/api/
