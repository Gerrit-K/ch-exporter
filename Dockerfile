FROM python:3.11

# Create workdir
ENV APP_DIRECTORY=/app
WORKDIR $APP_DIRECTORY

RUN pip install poetry

# Install dependencies
COPY poetry.lock pyproject.toml ./
RUN poetry config virtualenvs.in-project true \
  && poetry install --no-interaction --no-ansi -vvv
COPY . ./

USER 1000:1000

CMD ["/app/.venv/bin/uvicorn", "--host", "0.0.0.0", "--port", "8000", "main:app"]


