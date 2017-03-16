FROM ubuntu:14.04
MAINTAINER Jacob Gathercole

RUN apt-get update
RUN apt-get install -y build-essential python3-dev python3-pip
RUN pip3 -q install gunicorn eventlet



COPY / /opt/

RUN pip3 install -q -r /opt/requirements.txt && \
    pip3 install -q -r /opt/requirements_test.txt

EXPOSE 8000

WORKDIR /opt

CMD ["/usr/local/bin/gunicorn", "-k", "eventlet", "--pythonpath", "/opt", "--access-logfile", "-", "manage:manager.app", "--reload", "-b", "0.0.0.0:8000"]
