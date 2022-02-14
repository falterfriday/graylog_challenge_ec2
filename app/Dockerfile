FROM python:alpine

COPY . ./app
WORKDIR /app

RUN pip install flask

ENTRYPOINT ["python"]

CMD ["hello-graylog.py"]