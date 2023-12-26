FROM alpine

RUN apk add --update python3 py3-pip
WORKDIR /app
COPY . /app

# Встановлення Flask віртуальним середовищем
RUN python3 -m venv /venv
RUN source /venv/bin/activate && /venv/bin/pip install --no-cache-dir --disable-pip-version-check Flask
RUN /venv/bin/pip install --no-cache-dir --disable-pip-version-check xmlrunner

EXPOSE 5000
ENTRYPOINT ["/venv/bin/python3"]
CMD ["test.py"]
