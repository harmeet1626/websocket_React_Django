from chats.seriailizers import UserSerializer
from chats.seriailizers import ConversationSerializer
from chats.models import Conversation, Message
from chats.seriailizers import MessageSerializer, CreateUserSerializer, UploadDocumentsSerializer
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
        # Override the create method to handle password hashing
        password = request.data.get('password')
        request.data['password'] = make_password(password)  # Assuming you are using Django's make_password function

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
