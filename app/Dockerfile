FROM python:3.6

COPY . ./app
WORKDIR /app

RUN pip install flask

ENTRYPOINT ["python"]

CMD ["hello-graylog.py"]