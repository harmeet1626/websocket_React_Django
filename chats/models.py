import uuid
from cryptography.fernet import Fernet
from django.contrib.auth import get_user_model
from django.db import models
User = get_user_model()



class Conversation(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=128)
    online = models.ManyToManyField(to=User, blank=True)

    def get_online_count(self):
        return self.online.count()

    def join(self, user):
        self.online.add(user)
        self.save()

    def leave(self, user):
        self.online.remove(user)
        self.save()

    def __str__(self):
        return f"{self.name} ({self.get_online_count()})"



class Message(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    conversation = models.ForeignKey(Conversation, on_delete=models.CASCADE, related_name="messages")
    from_user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="messages_from_me")
    to_user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="messages_to_me")
    content = models.BinaryField(max_length=10000,blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)
    read = models.BooleanField(default=False)
    file = models.FileField(upload_to='static/file', null=True, blank=True)
    decode_key = models.BinaryField(max_length=10000, blank=True)


    def save(self, *args, **kwargs):
        # Encrypt the content before saving
        key = Fernet.generate_key()
        self.decode_key=key
        cipher = Fernet(key)
        content = cipher.encrypt(self.content.encode())
        self.content = content
        super().save(*args, **kwargs)
    

    def __str__(self):
        return f"From {self.from_user.username} to {self.to_user.username}: {self.content} [{self.timestamp}]"


class Media(models.Model):    
    file = models.FileField(upload_to='static/file', null=True, blank=True)



class Groups(models.Model):
    name = models.CharField(max_length=500)


class Participants(models.Model):
    group = models.ForeignKey(Groups, on_delete = models.CASCADE)
    user = models.ForeignKey(User, on_delete = models.CASCADE)

class Group_content(models.Model):
    group = models.ForeignKey(Groups, on_delete = models.CASCADE)
    content = models.CharField(max_length=500,blank=True)
    from_user = models.ForeignKey(User, on_delete = models.CASCADE)
    timestamp = models.DateTimeField(auto_now_add=True)
    file = models.FileField(upload_to='static/file', null=True, blank=True)
