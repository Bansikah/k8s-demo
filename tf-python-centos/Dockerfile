FROM centos:7

RUN yum -y install epel-release && yum clean
RUN yum -y install python-pip && yum clean

WORKDIR /app

COPY . .

CMD [ "python", "-u", "app.py" ]