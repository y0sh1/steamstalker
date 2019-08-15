FROM balenalib/raspberrypi3-python:3.7

RUN [ "cross-build-start" ]

RUN apt update
RUN apt install gcc

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY steamstalker.py ./

RUN [ "cross-build-end" ]

CMD [ "python", "./steamstalker.py" ]