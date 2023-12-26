FROM alpine

RUN apk add --update python3 py3-pip
WORKDIR /app
COPY . /app

# Встановлення Flask без використання віртуального середовища
RUN pip install Flask
RUN pip install xmlrunner

EXPOSE 5000
ENTRYPOINT [ "python3" ]  # Використання python3 замість python
CMD ["test.py"]

