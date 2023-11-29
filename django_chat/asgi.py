import os

from django.core.asgi import get_asgi_application
from chats.middleware import TokenAuthMiddleware
from django_chat import routing
from channels.routing import ProtocolTypeRouter, URLRouter

django_application = get_asgi_application()

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'django_chat.settings')

application = ProtocolTypeRouter(
    {
        "http": get_asgi_application(),
        "websocket": TokenAuthMiddleware(URLRouter(routing.websocket_urlpatterns)),
    }
)

