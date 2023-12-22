from django.urls import path

from chats.consumers import ChatConsumer, NotificationConsumer, GroupChat

websocket_urlpatterns = [
    path("chats/<conversation_name>/", ChatConsumer.as_asgi()),
    path("notifications/", NotificationConsumer.as_asgi()),
    path("groupChat/<group_name>/", GroupChat.as_asgi()),
    ]

