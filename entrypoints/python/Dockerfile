FROM python:3.9.6-alpine3.14

# Defining entrypoint
WORKDIR /usr/src/app

# Copy requirements to entrypoint.
COPY ./requirements /usr/src/app/


# Install requirements:
RUN apk update
RUN apk --update add --no-cache g++
RUN apk add build-base postgresql-dev libpq --no-cache --virtual .build-deps;
RUN echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN pip3 install --no-cache-dir --upgrade pip ;
RUN pip3 install --upgrade setuptools;
RUN pip3 install --no-cache-dir -r requirements;

EXPOSE 81
