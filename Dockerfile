FROM alpine

RUN apk add --update python3 py3-pip
RUN python3 -m venv /venv

WORKDIR /app
COPY . /app

# Активуємо віртуальне середовище та встановлюємо Flask
RUN /venv/bin/pip install --no-cache-dir --disable-pip-version-check Flask

EXPOSE 5000
ENTRYPOINT [ "/venv/bin/python" ]
CMD ["test.py"]
