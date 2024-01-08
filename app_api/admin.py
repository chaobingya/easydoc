from django.contrib import admin

from app_api.models import UserToken, AppUserToken

# Register your models here.
admin.site.register((UserToken,AppUserToken))