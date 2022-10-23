FROM python:slim

LABEL application=topsec-web maintainer="Topsec, Inc. <zhao_lanbao@topsec.com.cn>" maintainer="rambo.site"
ENV PYTHONUNBUFFERED=0 \
    TZ=Asia/Shanghai \
    LISTEN_PORT=80\
    USER=chaobing

RUN set -ex && \
   sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list &&\
   apt update &&\
   apt-get install -y apt-transport-https ca-certificates libgl1-mesa-dev  libglib2.0-dev \
   build-essential python-dev default-libmysqlclient-dev netcat &&\
   cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&  echo "Asia/Shanghai" > /etc/timezone &&\
   pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple


COPY ./requirements.txt /requirements.txt
#COPY ./config/sources.list /etc/apt/sources.list

# apk 更新太慢，剥离开，放到了第一层
RUN set -ex && \
    pip install --upgrade setuptools pip  --no-cache-dir && \
    pip install -r /requirements.txt --no-cache-dir  && \
#    pip --no-cache-dir install mysqlclient  uwsgi &&\
    rm -rf /root/.cache  /requirements.txt

RUN  echo "Asia/Shanghai" > /etc/timezone
COPY . /EasyDoc/
WORKDIR /EasyDoc/

# 移除\r in windows
RUN sed -i 's/\r//' start.sh
# 给start.sh可执行权限
RUN chmod +x start.sh
#数据迁移，并使用uwsgi启动服务
ENTRYPOINT ["./start.sh"]