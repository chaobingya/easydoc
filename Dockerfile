FROM python:slim

LABEL application=topsec-web maintainer="Topsec, Inc. <zhao_lanbao@topsec.com.cn>" maintainer="rambo.site"
ENV PYTHONUNBUFFERED=0 \
    TZ=Asia/Shanghai \
    LISTEN_PORT=80\
    USER=chaobing \
    PATH="/opt/venv/bin:$PATH"

RUN set -ex && \
   apt install apt-transport-https ca-certificates&&apt update &&\
   cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&  echo "Asia/Shanghai" > /etc/timezone

RUN set -ex && python -m venv /opt/venv



COPY ./requirements.txt /requirements.txt

# apk 更新太慢，剥离开，放到了第一层
RUN set -ex && \
    python -m pip install --upgrade setuptools pip  --no-cache-dir  -i https://pypi.tuna.tsinghua.edu.cn/simple  && \
    pip install -r /requirements.txt --no-cache-dir  -i https://pypi.tuna.tsinghua.edu.cn/simple  && \
#    pip --no-cache-dir install  uwsgi -i https://pypi.tuna.tsinghua.edu.cn/simple  --proxy=http://10.8.22.241:8888 &&\
    rm -rf /root/.cache  /requirements.txt

RUN  echo "Asia/Shanghai" > /etc/timezone
COPY . /EasyDoc/
WORKDIR /EasyDoc/

RUN chmod +x docker_mrdoc.sh

ENTRYPOINT ["./docker_mrdoc.sh"]