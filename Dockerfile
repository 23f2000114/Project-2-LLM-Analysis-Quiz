FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    wget gnupg ca-certificates curl unzip \
    libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libxkbcommon0 \
    libgtk-3-0 libgbm1 libasound2 libxcomposite1 libxdamage1 libxrandr2 \
    libxfixes3 libpango-1.0-0 libcairo2 \
     # Tesseract OCR engine
    tesseract-ocr \
    # FFmpeg for audio processing (pydub)
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

ENV PLAYWRIGHT_BROWSERS_PATH=/root/.cache/ms-playwright

RUN pip install playwright && playwright install chromium
RUN pip install uv

WORKDIR /app

COPY pyproject.toml uv.lock ./
COPY . .

ENV PYTHONUNBUFFERED=1
ENV PYTHONIOENCODING=utf-8
ENV GOOGLE_API_KEY=${GOOGLE_API_KEY}

RUN uv sync --frozen

EXPOSE 7860

CMD ["uv", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7860"]

