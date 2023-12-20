# Generated by Django 4.1.4 on 2023-12-20 06:36

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('chats', '0011_alter_message_content'),
    ]

    operations = [
        migrations.AlterField(
            model_name='message',
            name='content',
            field=models.CharField(blank=True, max_length=10000),
        ),
        migrations.AlterField(
            model_name='message',
            name='decode_key',
            field=models.BinaryField(blank=True, max_length=100),
        ),
    ]