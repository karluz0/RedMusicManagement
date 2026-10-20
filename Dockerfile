# Extract the reviewed source archive before building the application.
FROM python:3.11-slim-bookworm AS source
WORKDIR /src
COPY redmusicmanagement-publicacao.zip /tmp/source.zip
RUN python -m zipfile -e /tmp/source.zip /src

FROM node:22-bookworm-slim AS frontend
WORKDIR /build/frontend
COPY --from=source /src/redmusicmanagement/frontend/ ./
RUN npm ci --no-audit --no-fund
ENV REACT_APP_BACKEND_URL=""
ENV GENERATE_SOURCEMAP=false
RUN npm run build

FROM python:3.11-slim-bookworm
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
WORKDIR /app
COPY --from=source /src/redmusicmanagement/backend/requirements-deploy.txt /app/backend/requirements-deploy.txt
RUN pip install --no-cache-dir -r /app/backend/requirements-deploy.txt
COPY --from=source /src/redmusicmanagement/backend/server.py /app/backend/server.py
COPY --from=frontend /build/frontend/build /app/frontend/build
RUN useradd --create-home appuser
USER appuser
EXPOSE 10000
CMD ["sh", "-c", "uvicorn backend.server:app --host 0.0.0.0 --port ${PORT:-10000}"]
