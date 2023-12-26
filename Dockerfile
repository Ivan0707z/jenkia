FROM alpine
RUN apk add --update python3 py-pip
RUN pip install Flask
RUN pip install xmlrunner
WORKDIR /app
COPY . /app
EXPOSE 5000
ENTRYPOINT [ "python" ]
CMD ["test.py"]
