FROM alpine

RUN apk add --update python3 py3-pip
WORKDIR /app
COPY . /app

# Видалення віртуального середовища
RUN python3 -m venv /venv
RUN /venv/bin/pip uninstall -y pip
RUN rm -rf /venv

# Встановлення Flask без використання віртуального середовища
RUN pip install --no-cache-dir --disable-pip-version-check Flask
RUN pip install --no-cache-dir --disable-pip-version-check xmlrunner

EXPOSE 5000
ENTRYPOINT [ "python3" ]
CMD ["test.py"]
