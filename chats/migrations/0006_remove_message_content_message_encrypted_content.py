# Generated by Django 4.1.4 on 2023-12-19 11:18

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('chats', '0005_media'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='message',
            name='content',
        ),
        migrations.AddField(
            model_name='message',
            name='encrypted_content',
            field=models.BinaryField(blank=True),
        ),
    ]