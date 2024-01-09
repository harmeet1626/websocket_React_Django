from chats.seriailizers import UserSerializer
from chats.seriailizers import ConversationSerializer
from chats.models import Conversation, Message, Participants, Groups, Group_content, User_Image
from chats.seriailizers import MessageSerializer, CreateUserSerializer, UploadDocumentsSerializer, ParticipantSerializer, Group_content_serializer, Groups_serializers, UserImageSerializer
from rest_framework.authtoken.models import Token
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.response import Response
from django.contrib.auth.models import User
from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from chats.paginators import MessagePagination
from rest_framework.generics import ListAPIView, CreateAPIView, UpdateAPIView
from django.contrib.auth.hashers import make_password
from datetime import date
from rest_framework.views import APIView



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
                # groupName.append(i['name'])
                groupName.append({
                    "groupName":i['name'],
                    "groupImage":i['image']
                })
        return groupName
    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        return Response({"res": queryset})


    

class CreateGroup(CreateAPIView):
    queryset = Groups.objects.all()
    serializer_class = Groups_serializers

    def perform_create(self, serializer):
        group_name = self.request.data.get('name', None)
        created_by = self.request.data.get('Created_by', None)
        admin = User.objects.get(username=created_by)

        if group_name:
            existing_group = Groups.objects.filter(name__iexact=group_name)
            if existing_group.exists():
                response_data = {'detail': f'A group with the name "{group_name}" already exists.'}
                return Response(response_data, status=400)

        username_list = self.request.data.get('usernames', [])
        group = serializer.save(Created_by=created_by, Admin=admin, Created_on=date.today())
        for username in username_list:
            user = User.objects.get(username=username)
            Participants.objects.create(group=group, user=user)

        return Response({'detail': 'Group created successfully.'})



class GetGroupParticipants(ListAPIView):
    queryset = Participants.objects.all()
    serializer_class = ParticipantSerializer

    def get_queryset(self):
        group_name = self.kwargs.get('group_name')
        queryset = Participants.objects.filter(group__name=group_name)
        admin = Groups.objects.filter(name=group_name).values("Admin_id__username","Created_by","Created_on","image").first()
        CreatedBy = admin['Created_by']
        CreatedOn = admin['Created_on']
        groupImage = admin['image']
        admin_username = admin['Admin_id__username'] if admin else None

        res = {
            "admin": admin_username,
            "Created_by":CreatedBy,
            "created_on":CreatedOn,
            "Group_image":groupImage,
            "Participants": self.serializer_class(queryset, many=True).data
        }
        return queryset, res

    def list(self, request, *args, **kwargs):
        queryset, res = self.get_queryset()
        return Response(res)

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
    


class GetSingleUser(ListAPIView):
    queryset = User.objects.all()
    serializer_class =UserSerializer
    def get_queryset(self):
        user_name = self.kwargs.get('username')
        userInstance = User.objects.get(username = user_name)
        image = User_Image.objects.filter(user = userInstance)
        image 
        for i in image:
            image = i.image
        res = {
            "username": user_name,
            "user_image": str(image)
        }
        return Response(res)
    def list(self, request, *args, **kwargs):
        res = self.get_queryset()
        return res
    


class UpdatedGroupAdmin(UpdateAPIView):
    queryset = Groups.objects.all()
    serializer_class = Groups_serializers
    def put(self, request, *args, **kwargs):
        username = request.data.get('user')
        group_name = request.data.get('group')
        try:
            user_instance = User.objects.get(username=username)
        except User.DoesNotExist:
            return Response({'error': 'User not found'}, status=404)

        try:
            group_instance = Groups.objects.get(name=group_name)
        except Groups.DoesNotExist:
            return Response({'error': 'Group not found'}, status=404)
        serializer = self.get_serializer(group_instance, data={'Admin': user_instance.id}, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response('Group Admin Updated')
    


class UpdateGroupImage(UpdateAPIView):
    queryset = Groups.objects.all()
    serializer_class = Groups_serializers
    def put(self, request, *args, **kwargs):
        image = request.data.get('image')
        group_name = self.kwargs.get('group_name')
        group_instance = Groups.objects.get(name = group_name)
        serializer = self.get_serializer(group_instance, data={"image": (image)}, partial = True)
        if serializer.is_valid():
            serializer.save()
            return Response("image updated")
        else:
            return Response(serializer.errors)


class UpdateUserImage(UpdateAPIView):
    queryset = User_Image.objects.all()
    serializer_class = UserImageSerializer

    def put(self, request, *args, **kwargs):
        username = self.kwargs.get('username')
        user_instance = User.objects.get(username=username)
        user_image_instance, created = User_Image.objects.get_or_create(user=user_instance)
        
        # Update the existing user image record
        serializer = self.get_serializer(user_image_instance, data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save(user=user_instance)

        return Response("Image updated")
        
    

class GetCurrentUser(APIView):
    def get(self, request, *args, **kwargs):
        # Check if the user is authenticated
        if request.user.is_authenticated:
            current_user = request.user
            userDetails = User.objects.get(username = current_user)
            userImage = User_Image.objects.filter(user__username = userDetails).values().first()
            

            res = {
                "username":userDetails.username,
                "userimage":str(userImage['image']),
                "userEmail":str(userDetails.email)
            }         
            return Response(res)
        else:
            return Response({"message": "User is not authenticated"})