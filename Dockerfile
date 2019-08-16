FROM balenalib/raspberrypi3-python:3.7

RUN [ "cross-build-start" ]

RUN apt update
RUN apt install gcc build-essential libssl-dev libffi-dev python3-dev

WORKDIR /usr/src/app

RUN mkdir /usr/src/app/storage

COPY requirements.txt steamstalker.py ./
RUN pip install --no-cache-dir -r requirements.txt

RUN [ "cross-build-end" ]

CMD [ "python", "./steamstalker.py" ]