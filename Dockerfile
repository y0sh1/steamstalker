FROM balenalib/raspberrypi3-python:3.7

RUN [ "cross-build-start" ]

RUN apt update
RUN apt install gcc build-essential libssl-dev libffi-dev python-dev

WORKDIR /usr/src/app

RUN mkdir /usr/src/app/storage

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY steamstalker.py ./

RUN [ "cross-build-end" ]

CMD [ "python", "./steamstalker.py" ]