#!/bin/sh

# 生成数据库迁移文件
python /EasyDoc/manage.py makemigrations app_doc app_admin app_api &&
# 根据数据库迁移文件执行数据库变更
python /EasyDoc/manage.py migrate &&
# 重建全文搜索索引
nohup echo y |python /EasyDoc/manage.py rebuild_index &&
# 启动uwsgi
uwsgi --ini /EasyDoc/config/uwsgi.ini
# 直接 runserver 方式运行
#python -u /EasyDoc/manage.py runserver --noreload 0.0.0.0:${LISTEN_PORT}
exec "$@"