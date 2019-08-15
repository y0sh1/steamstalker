FROM balenalib/raspberrypi3-python:latest

RUN [ "cross-build-start" ]

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY steamstalker.py ./

RUN [ "cross-build-end" ]

CMD [ "python", "./steamstalker.py" ]