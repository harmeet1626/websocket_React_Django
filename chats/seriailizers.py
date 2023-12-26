from chats.models import Conversation
from rest_framework import serializers
from cryptography.fernet import Fernet
import base64
from rest_framework.response import Response
from chats.models import Message, Media, Participants, Group_content, Groups
from django.contrib.auth.models import User


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ["username"]




class UploadDocumentsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Media
        fields = ["file"]
       


class MessageSerializer(serializers.ModelSerializer):
    from_user = serializers.SerializerMethodField()
    to_user = serializers.SerializerMethodField()
    conversation = serializers.SerializerMethodField()
    decode_key = serializers.SerializerMethodField()
    content = serializers.SerializerMethodField()

    class Meta:
        model = Message
        fields = ("__all__")

    def get_decode_key(self, obj):
        try:            
            binary_data = Message.objects.get(id=obj.id)
        except Message.DoesNotExist:
            return Response(status=404)
        serializer = BinaryDataSerializer(binary_data)
        return serializer.data['decode_key']
    
    def get_content(self, obj):
        key = obj.decode_key
        cipher = Fernet(key)
        decrypted_text = cipher.decrypt(obj.content).decode()
        return decrypted_text

    def get_conversation(self, obj):
        return str(obj.conversation.id)

    def get_from_user(self, obj):
        return UserSerializer(obj.from_user).data

    def get_to_user(self, obj):
        return UserSerializer(obj.to_user).data




class BinaryDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message
        fields = ['decode_key']


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


class participantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Participants
        fields = '__all__'




class Group_content_serializer(serializers.ModelSerializer):
    from_user_id = serializers.SerializerMethodField()
    class Meta:
        model = Group_content
        fields = ["group_id","content", 'from_user_id', "timestamp"]
    
    def get_from_user_id(self, obj):
        user_id = obj['from_user_id']
        user = User.objects.get(id=user_id)
        username = user.username
        return username
        

    



class Groups_serializers(serializers.ModelSerializer):
    class Meta:
        model = Groups
        fields = ['name']


