# Generated by Django 4.1.4 on 2023-12-18 12:58

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('chats', '0002_message_file'),
    ]

    operations = [
        migrations.AlterField(
            model_name='message',
            name='content',
            field=models.CharField(blank=True, max_length=512),
        ),
    ]