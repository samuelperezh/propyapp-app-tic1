FROM python:3.11.5-slim

ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY requirements.txt .

RUN pip install -r requirements.txt

COPY api.py .
COPY /data/modelo-PropyApp.pkl ./data/modelo-PropyApp.pkl

EXPOSE 8000

CMD ["uvicorn", "api:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]