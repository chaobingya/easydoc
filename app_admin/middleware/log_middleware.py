import time

from django.utils.deprecation import MiddlewareMixin

from app_admin.models import UserLog

# 定义需要记录日志的url名单
include_urls = {
    'login': {
        'method': {
            'POST': "登录"
        }
    }
}


class UserLogs(MiddlewareMixin):
    """
    用户日志
    """

    def __init__(self, *args):
        super(UserLogs, self).__init__(*args)

    # def process_response(self, request, response):
    #     """
    #     响应返回
    #     :param request: 请求对象
    #     :param response: 响应对象
    #     :return: response
    #     """
    #     path = request.path
    #     method = request.method
    #     user = request.POST.get("username")
    #     status_code = response.status_code  # int 302
    #     print("UserLogs Middleware")
    #     print("{0} {1} {2} {3} {4}".format(time.time(), user, '登录', status_code, ''))
    #     # 请求url在 exclude_urls中，直接return，不保存操作日志记录
    #     # for url in self.__exclude_urls:
    #     #     if url in self.data.get('re_url'):
    #     #         return response
    #     x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    #     if x_forwarded_for:
    #         # 如果有代理，获取真实IP
    #         ip = x_forwarded_for.split(",")[0]
    #     else:
    #         ip = request.META.get('REMOTE_ADDR')
    #
    #     # 获取响应数据字符串(多用于API, 返回JSON字符串)
    #     # rp_content = response.streaming_content
    #     # self.data['rp_content'] = rp_content
    #     # print(request)
    #     # print(response)
    #     # UserLog.objects.create(user=user, ip=ip, moudle='认证', method='登录', status=True if status_code > 399 else False,
    #     #                        content='')  # 操作日志入库db
    #
    #     return response
