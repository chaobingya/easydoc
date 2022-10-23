#!/bin/bash

# 1. 等待MySQL、redis服务启动后再进行数据迁移。nc即netcat缩写
while ! nc -z db 3306 ; do
    echo "Waiting for the MySQL Server"
    sleep 3
done
while ! nc -z redis 6379 ; do
    echo "Waiting for the Redis Server"
    sleep 3
done

# 2. 收集静态文件到根目录static文件夹
# python /EasyDoc/manage.py collectstatic --noinput&&
# 3. 生成数据库可执行、迁移文件
python /EasyDoc/manage.py makemigrations app_doc app_admin app_api &&
# 4. 根据数据库可执行文件来修改数据库
python /EasyDoc/manage.py migrate &&
# 5. 重建全文搜索索引
nohup echo y |python /EasyDoc/manage.py rebuild_index &&
# 6. 用 uwsgi启动 django 服务
uwsgi --ini /EasyDoc/config/uwsgi/uwsgi.ini
# 直接 runserver 方式运行
#python -u /EasyDoc/manage.py runserver --noreload 0.0.0.0:${LISTEN_PORT}
# 7. tail空命令防止web容器执行脚本后退出
tail -f /dev/null

exec "$@"