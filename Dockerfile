FROM arm32v7/python:3

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY steamstalker.py ./

CMD [ "python", "./steamstalker.py" ]