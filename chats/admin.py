from django.contrib import admin

# Register your models here.
from .models import Groups, Participants, Group_content, User_Image

admin.site.register(Groups)
admin.site.register(Participants)
admin.site.register(Group_content)
admin.site.register(User_Image)