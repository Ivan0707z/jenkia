FROM alpine

RUN apk add --update python3 py3-pip
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

WORKDIR /app
COPY . /app

RUN pip install Flask
RUN pip install xmlrunner

EXPOSE 5000
ENTRYPOINT [ "python" ]
CMD ["test.py"]

RUN rm -rf /venv
