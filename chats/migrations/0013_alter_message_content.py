# Generated by Django 4.1.4 on 2023-12-20 10:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('chats', '0012_alter_message_content_alter_message_decode_key'),
    ]

    operations = [
        migrations.AlterField(
            model_name='message',
            name='content',
            field=models.BinaryField(blank=True, max_length=10000),
        ),
    ]