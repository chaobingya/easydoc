from django.contrib import admin

from app_admin.models import SysSetting, UserOptions, EmaiVerificationCode, RegisterCode, UserLog

# Register your models here.
admin.site.register((SysSetting,UserOptions,EmaiVerificationCode,RegisterCode,UserLog))
