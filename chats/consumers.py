from asgiref.sync import async_to_sync
from channels.generic.websocket import JsonWebsocketConsumer
from chats.models import Conversation, Message, Groups, Group_content
from django.contrib.auth.models import User
from chats.seriailizers import MessageSerializer, Group_content_serializer
import json
from uuid import UUID
from channels.layers import get_channel_layer




class UUIDEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, UUID):
            # if the obj is uuid, we simply return the value of uuid
            return obj.hex
        return json.JSONEncoder.default(self, obj)


class ChatConsumer(JsonWebsocketConsumer):
    def __init__(self, *args, **kwargs):
        super().__init__(args, kwargs)
        self.room_name = None
        self.user = None
        self.conversation_name = None
        self.conversation = None

    def connect(self):
        self.user = self.scope["user"]
        if not self.user.is_authenticated:
            return

        print("Connected!")
        self.room_name = "home"
        self.accept()
        self.conversation_name = f"{self.scope['url_route']['kwargs']['conversation_name']}"
        self.conversation, created = Conversation.objects.get_or_create(
            name=self.conversation_name)
        async_to_sync(self.channel_layer.group_add)(
            self.conversation_name,
            self.channel_name,
        )


        self.send_json(
            {
                "type": "online_user_list",
                "users": [user.username for user in self.conversation.online.all()],
            }
        )

        async_to_sync(self.channel_layer.group_send)(
            self.conversation_name,
            {
                "type": "user_join",
                "user": self.user.username,
            },
        )

        self.conversation.online.add(self.user)

        messages = self.conversation.messages.all().order_by(
            "-timestamp")[0:50]
        message_count = self.conversation.messages.all().count()
        self.send_json(
            {
                "type": "last_50_messages",
                "messages": MessageSerializer(messages, many=True).data,
                "has_more": message_count > 50,
            }
        )

    def disconnect(self, code):
        if self.user.is_authenticated:  # send the leave event to the room
            async_to_sync(self.channel_layer.group_send)(
                self.conversation_name,
                {
                    "type": "user_leave",
                    "user": self.user.username,
                },
            )
            self.conversation.online.remove(self.user)
        return super().disconnect(code)

    def get_receiver(self):
        usernames = self.conversation_name.split("__")
        for username in usernames:
            if username != self.user.username:
                # This is the receiver
                return User.objects.get(username=username) 

    def receive_json(self, content, **kwargs ):
        message_type = content["type"]

        if message_type == "file":
            
            file_content = content.get('file_url', '')
            message = Message.objects.create(
                from_user=self.user,
                to_user=self.get_receiver(),
                content="",
                conversation=self.conversation,
                file=file_content
            )

            async_to_sync(self.channel_layer.group_send)(
                self.conversation_name,
                {
                    "type": "chat_message_echo",
                    "name": self.user.username,
                    "message": MessageSerializer(message).data,
                },
            )

            notification_group_name = self.get_receiver().username + "__notifications"
            async_to_sync(self.channel_layer.group_send)(
                notification_group_name,
                {
                    "type": "new_message_notification",
                    "name": self.user.username,
                    "message": MessageSerializer(message).data,
                },
            )

        if message_type == "chat_message":
            message = Message.objects.create(
                from_user=self.user,
                to_user=self.get_receiver(),
                content=content["message"],
                conversation=self.conversation
            )
            channel_layer = get_channel_layer()

            async_to_sync(channel_layer.group_send)(
                self.conversation_name,
                {
                    "type": "chat_message_echo",
                    "name": self.user.username,
                    "message": MessageSerializer(message).data,
                },
            )

            # notification_group_name = self.get_receiver().username + "__notifications"
            # async_to_sync(self.channel_layer.group_send)(
            #     notification_group_name,
            #     {
            #         "type": "new_message_notification",
            #         "name": self.user.username,
            #         "message": MessageSerializer(message).data,
            #     },
            # )        
       
               




        if message_type == "typing":
            async_to_sync(self.channel_layer.group_send)(
                self.conversation_name,
                {
                    "type": "typing",
                    "user": self.user.username,
                    "typing": content["typing"],
                },
            )
            

        if message_type == "read_messages":
            print('message readed')
            messages_to_me = self.conversation.messages.filter(
                to_user=self.user)
            messages_to_me.update(read=True)
            

            # Update the unread message count
            unread_count = Message.objects.filter(
                to_user=self.user, read=False).count()
            
            async_to_sync(self.channel_layer.group_send)(
                self.user.username + "__notifications",
                {
                    "type": "unread_count",
                    "unread_count": unread_count,
                },
            )
            # message = Message.objects.filter().all().values()
            # print(message)
            # async_to_sync(self.channel_layer.group_send)(
            #     self.conversation_name,
            #     {
            #         "type": "read_messages",
            #         "name": self.user.username,
            #         "message": MessageSerializer(message).data,
            #     },
            # )

        return super().receive_json(content, **kwargs)
    
        
    
   


    def typing(self, event):
        self.send_json(event)

    def chat_message_echo(self, event):
        self.send_json(event)

    def user_join(self, event):
        self.send_json(event)

    def user_leave(self, event):
        self.send_json(event)

    @classmethod
    def encode_json(cls, content):
        return json.dumps(content, cls=UUIDEncoder)



class NotificationConsumer(JsonWebsocketConsumer):
    def __init__(self, *args, **kwargs):
        super().__init__(args, kwargs)
        self.user = None

    def connect(self):

        self.user = self.scope["user"]
        if not self.user.is_authenticated:
            return

        self.accept()

        unread_count = Message.objects.filter(
            to_user=self.user, read=False).count()
        self.send_json(
            {
                "type": "unread_count",
                "unread_count": unread_count,
            }
        )
        self.notification_group_name = self.user.username + "__notifications"
        async_to_sync(self.channel_layer.group_add)(
            self.notification_group_name,
            self.channel_name,
        )

    def disconnect(self, code):
        async_to_sync(self.channel_layer.group_discard)(
            self.notification_group_name,
            self.channel_name,
        )
        return super().disconnect(code)

    def new_message_notification(self, event):
        self.send_json(event)

    def unread_count(self, event):
        self.send_json(event)



class GroupChat(JsonWebsocketConsumer):
    def __init__(self, *args, **kwargs):
        super().__init__(args, kwargs)
        self.room_name = None
        self.user = None
        self.group_name = None
        self.group = None

    def connect(self):
        self.user = self.scope["user"]
        if not self.user.is_authenticated:
            return

        print("Connected!")
        self.room_name = "home"
        self.accept()
        self.group_name = f"{self.scope['url_route']['kwargs']['group_name']}"
        self.group = Groups.objects.filter(name = self.group_name ).values()

        async_to_sync(self.channel_layer.group_add)(
            self.group_name,
            self.channel_name,
        )


        messages = Group_content.objects.filter(group_id = self.group[0]['id']).order_by( "-timestamp").values()
        self.send_json(
            {
                "type": "last_50_messages",
                "messages": Group_content_serializer(messages, many=True).data,
                # "has_more": message_count > 50,
            }
        )

    def disconnect(self, code):
        if self.user.is_authenticated:  # send the leave event to the room
            async_to_sync(self.channel_layer.group_send)(
                self.group_name,
                {
                    "type": "user_leave",
                    "user": self.user.username,
                },
            )
        return super().disconnect(code)
    

    def chat_message_echo(self, event):
        self.send_json(event)
    def receive_json(self, content, **kwargs ):
        message_type = content["type"]       

        if message_type == "group_chat_message":
            content=content["message"]
            group_id = self.group[0]['id']
            group_instance = Groups.objects.get(id = group_id)
            messageSerializer = Group_content.objects.create(
                group = group_instance,
                from_user=self.user,
                content=content,
            )

            messages = Group_content.objects.filter(group_id = self.group[0]['id']).order_by( "-timestamp").values()


            async_to_sync(self.channel_layer.group_send)(
                self.group_name,
                {
                    "type": "chat_message_echo",
                    "name": self.user.username,
                    "message": Group_content_serializer(messages, many=True).data,
                },
            )


        if message_type == "group_file":        
            content = content.get('file_url', '')
            group_id = self.group[0]['id']
            user_id = self.user.id
            group_instance = Groups.objects.get(id = group_id)
            messageSerializer = Group_content.objects.create(
                group = group_instance,
                from_user=self.user,
                file=content,
            )
            messages = Group_content.objects.filter(group_id = self.group[0]['id']).order_by( "-timestamp").values()


            async_to_sync(self.channel_layer.group_send)(
                self.group_name,
                {
                    "type": "chat_message_echo",
                    "name": self.user.username,
                    "message": Group_content_serializer(messages, many=True).data,
                },
            )


           

        if message_type == "group_typing":
            async_to_sync(self.channel_layer.group_send)(
                self.conversation_name,
                {
                    "type": "typing",
                    "user": self.user.username,
                    "typing": content["typing"],
                },
            )
            

        if message_type == "group_read_messages":
            print('message readed')
            messages_to_me = self.conversation.messages.filter(
                to_user=self.user)
            messages_to_me.update(read=True)

            # Update the unread message count
            unread_count = Message.objects.filter(
                to_user=self.user, read=False).count()
            async_to_sync(self.channel_layer.group_send)(
                self.user.username + "__notifications",
                {
                    "type": "unread_count",
                    "unread_count": unread_count,
                },
            )

        return super().receive_json(content, **kwargs)