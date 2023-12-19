from chats.models import Conversation
from rest_framework import serializers

from chats.models import Message, Media
from django.contrib.auth.models import User


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ["username"]




class UploadDocumentsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Media
        fields = ["file"]
        # fields = ["conversation", "from_user", 'to_user', "content", "timestamp", "read", "file"]
       


class MessageSerializer(serializers.ModelSerializer):
    from_user = serializers.SerializerMethodField()
    to_user = serializers.SerializerMethodField()
    conversation = serializers.SerializerMethodField()

    class Meta:
        model = Message
        fields = ("__all__")
        # fields = (
        #     "id",
        #     "conversation",
        #     "from_user",
        #     "to_user",
        #     "content",
        #     "timestamp",
        #     "read",
        #     "file"
        # )

    def get_conversation(self, obj):
        return str(obj.conversation.id)

    def get_from_user(self, obj):
        return UserSerializer(obj.from_user).data

    def get_to_user(self, obj):
        return UserSerializer(obj.to_user).data


class ConversationSerializer(serializers.ModelSerializer):
    other_user = serializers.SerializerMethodField()
    last_message = serializers.SerializerMethodField()

    class Meta:
        model = Conversation
        fields = ("id", "name", "other_user", "last_message")

    def get_last_message(self, obj):
        messages = obj.messages.all().order_by("-timestamp")
        if not messages.exists():
            return None
        message = messages[0]
        return MessageSerializer(message).data

    def get_other_user(self, obj):
        usernames = obj.name.split("__")
        context = {}
        for username in usernames:
            if username != self.context["user"].username:
                # This is the other participant
                other_user = User.objects.get(username=username)
                return UserSerializer(other_user, context=context).data


class CreateUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'password']  # Add other fields as needed