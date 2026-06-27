# ── Stage 1: Install dependencies into isolated prefix ───────────────────────
FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ── Stage 2: Minimal runtime image ───────────────────────────────────────────
FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /install /usr/local
COPY app.py .
EXPOSE 8082
CMD ["python", "app.py"]
