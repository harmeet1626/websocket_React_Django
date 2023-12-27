from django.contrib import admin
from django.urls import path, include
from chats.views import CustomObtainAuthTokenView
from chats.views import ConversationViewSet, MessageViewSet,UserViewSet, CreateUserView,UploadDocument, User_group, CreateGroup
from rest_framework.routers import DefaultRouter


router = DefaultRouter()
router.register('users', UserViewSet)
router.register("conversations", ConversationViewSet)
router.register("messages", MessageViewSet)

urlpatterns = router.urls + [
    path('admin/', admin.site.urls),
    path("auth-token/", CustomObtainAuthTokenView.as_view()),
    path('create-user/', CreateUserView.as_view(), name='create-user'),
    path('documentUpload/',UploadDocument.as_view(), name='documentUpload'),
    path('UserGroup/',User_group.as_view(), name='User_group'),
    path('CreateGroup/',CreateGroup.as_view(), name='CreateGroup'),
]
