from django.contrib import admin

from app_doc.models import (Project,ProjectCollaborator,ProjectToc,Doc,DocHistory,DocTemp,DocShare,Tag,DocTag,ProjectReport,ProjectReportFile,
                     ImageGroup,Image,Attachment,MyCollect)

# Register your models here.
admin.site.register((Project,ProjectCollaborator,ProjectToc,Doc,DocHistory,DocTemp,DocShare,Tag,DocTag,ProjectReport,ProjectReportFile,
                     ImageGroup,Image,Attachment,MyCollect))