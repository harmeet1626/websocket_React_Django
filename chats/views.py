from chats.seriailizers import UserSerializer
from chats.seriailizers import ConversationSerializer
from chats.models import Conversation, Message, Participants, Groups, Group_content
from chats.seriailizers import MessageSerializer, CreateUserSerializer, UploadDocumentsSerializer, ParticipantSerializer, Group_content_serializer, Groups_serializers
from rest_framework.authtoken.models import Token
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.response import Response
from django.contrib.auth.models import User
from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from chats.paginators import MessagePagination
from rest_framework.generics import ListAPIView, CreateAPIView, UpdateAPIView
from django.contrib.auth.hashers import make_password
from rest_framework.views import APIView
from django.shortcuts import redirect
from django.http import JsonResponse


class CustomObtainAuthTokenView(ObtainAuthToken):
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data["user"]
        token, created = Token.objects.get_or_create(user=user)
        return Response({"token": token.key, "username": user.username})


class UserViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated,]
    serializer_class = UserSerializer
    queryset = User.objects.all()



class ConversationViewSet(viewsets.ModelViewSet):
    serializer_class = ConversationSerializer
    queryset = Conversation.objects.none()
    lookup_field = "name"

    def get_queryset(self):
        queryset = Conversation.objects.filter(
            name__contains=self.request.user.username
        )
        return queryset

    def get_serializer_context(self):
        return {"request": self.request, "user": self.request.user}


class MessageViewSet(viewsets.ModelViewSet):
    serializer_class = MessageSerializer
    queryset = Message.objects.none()
    pagination_class = MessagePagination

    def get_queryset(self):
        conversation_name = self.request.GET.get("conversation")
        queryset = (
            Message.objects.filter(
                conversation__name__contains=self.request.user.username,
            )
            .filter(conversation__name=conversation_name)
            .order_by("-timestamp")
        )
        return queryset
    

class CreateUserView(CreateAPIView):
    queryset = User.objects.all()
    serializer_class = CreateUserSerializer

    def create(self, request, *args, **kwargs):
        password = request.data.get('password')
        request.data['password'] = make_password(password)
        response = super().create(request, *args, **kwargs)
        return response
    

class UploadDocument(UpdateAPIView):
    queryset = Message.objects.all()
    serializer_class = UploadDocumentsSerializer
    def put(self, request):
        try:
            file = request.data.get('image')
            serializer = UploadDocumentsSerializer(data={
                'file':file
            })

            if serializer.is_valid():
                serializer.save()
                response_array = [{"text": "Your Document has uploaded Successfully", "file":serializer.data}]
                
                return Response({"status": 200, "response": response_array, "document": ""})
            else:
                print(serializer.errors)
                return Response({"status": 400, "error": serializer.errors})

        except Exception as e:
            print("Internal server error:", str(e))
            return Response({"status": 500, "error": str(e)})



class User_group(ListAPIView):
    serializer_class = Group_content_serializer
    def get_queryset(self):
        queryset = Participants.objects.filter(user__username=self.request.user).values()
        if not queryset:
            return Group_content.objects.none()        
        groupName = []
        for group in queryset:
            group = Groups.objects.filter(id = group['group_id']).values()
            for i in group:
                groupName.append(i['name'])
        return groupName

    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        return Response({"res": queryset})



# class CreateGroup(CreateAPIView):
#     queryset = Groups.objects.all()
#     serializer_class = Groups_serializers

#     def perform_create(self, serializer):
#         username_list = self.request.data.get('usernames', [])
#         group = serializer.save()

#         for username in username_list:
#             user = User.objects.get(username=username)
#             Participants.objects.create(group=group, user=user)
    
class CreateGroup(CreateAPIView):
    queryset = Groups.objects.all()
    serializer_class = Groups_serializers

    def perform_create(self, serializer):
        group_name = self.request.data.get('group_name', None)
        if group_name is not None:
            existing_group = Groups.objects.filter(group_name=group_name).first()

            if existing_group:
                # Group with the same name already exists
                response_data = {'detail': f'A group with the name "{group_name}" already exists.'}
                return Response(response_data, status=status.HTTP_400_BAD_REQUEST)

        username_list = self.request.data.get('usernames', [])
        group = serializer.save()

        for username in username_list:
            user = User.objects.get(username=username)
            Participants.objects.create(group=group, user=user)



class GetGroupParticipants(ListAPIView):
    queryset = Participants.objects.all()
    serializer_class = ParticipantSerializer
    def get_queryset(self):
        print("working!")
        queryset = super().get_queryset()
        group_name = self.kwargs.get('group_name')
        if group_name:
            queryset = queryset.filter(group__name=group_name)
        return queryset

class RemoveUserFromGroup(UpdateAPIView):
    queryset = Participants.objects.all()
    def put(self, request, *args, **kwargs):
        user = request.data.get('user')
        group = request.data.get('group')
        queryset = Participants.objects.filter(user=user, group=group)
        queryset.delete()
        return Response("User removed from group")
    
class AddParticipantInGroup(CreateAPIView):
    queryset = Participants.objects.all()
    def create(self, request, *args, **kwargs):
        user_instance = User.objects.get(username = request.data.get('user'))
        group_instance = Groups.objects.get(name = request.data.get('group'))
        queryset = Participants.objects.create(user = user_instance, group = group_instance)
        queryset.save()
        return Response("User added successfully")