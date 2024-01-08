from chats.models import Conversation
from rest_framework import serializers
from cryptography.fernet import Fernet
from rest_framework.response import Response
from chats.models import Message, Media, Participants, Group_content, Groups, User_Image
from django.contrib.auth.models import User
from datetime import date



class UserSerializer(serializers.ModelSerializer):
    user_picture = serializers.SerializerMethodField()
    class Meta:
        model = User
        fields = ["username", "user_picture"]
    def get_user_picture(self, instance):
        try:
            user_image = instance.user_image
            return str(user_image.image)
        except:
            # Return a default image URL or None if no user image is available
            return 'data:image/jpeg;base64,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'



class UserImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = User_Image
        fields = ['image']




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
        fields = ['id', 'username', 'email', 'password']  

    def create(self, validated_data):
        user_picture_data = validated_data.pop('user_picture', None)

        user = User.objects.create(**validated_data)

        if user_picture_data:
            User_Image.objects.create(user=user, image=user_picture_data)

        return user


class ParticipantSerializer(serializers.ModelSerializer):
    username = serializers.SerializerMethodField()
    group_name = serializers.SerializerMethodField()
    group_admin = serializers.SerializerMethodField()
    user_image = serializers.SerializerMethodField()
    class Meta:
        model = Participants
        fields = ['group', 'user', 'username', 'group_name', "group_admin" ,'user_image']

    def get_username(self, instance):
        user_instance = instance.user
        username = user_instance.username
        return username
    
    def get_group_name(self, instance):
        group_instance = instance.group
        group_name = group_instance.name 
        return group_name
    
    def get_group_admin(self, instance):
        groupName = self.get_group_name(instance)
        admin = Groups.objects.filter(name = groupName).values('Admin_id__username').first()
        return admin['Admin_id__username']
    

    def get_user_image(self, instance):
        userId = instance.user.id
        image = User_Image.objects.get(user = userId)
        return (str(image.image))
    

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        return representation





class Group_content_serializer(serializers.ModelSerializer):
    from_user_id = serializers.SerializerMethodField()
    file = serializers.SerializerMethodField()
    class Meta:
        model = Group_content
        fields = ["group_id", "content", 'from_user_id', "timestamp", "file"]
    
    def get_from_user_id(self, obj):
        user_id = obj['from_user_id']
        user = User.objects.get(id=user_id)
        username = user.username
        return username
    
    def get_file(self, obj):
        return obj['file']
    
    
class Groups_serializers(serializers.ModelSerializer):
    class Meta:
        model = Groups
        fields = ['name', 'Created_by', 'Created_on', 'Admin', "image"]
        



    


