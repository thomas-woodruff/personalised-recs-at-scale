FROM python:3.8-slim-buster

WORKDIR /home


# Install unzip command
RUN apt-get update && apt-get install -y unzip

# install requirements
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# install and enable jupyter extensions
RUN jupyter contrib nbextension install --user
RUN jupyter nbextension enable collapsible_headings/main
RUN jupyter nbextension enable execute_time/ExecuteTime

COPY . .
