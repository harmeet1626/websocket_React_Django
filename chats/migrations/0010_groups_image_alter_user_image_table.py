# Generated by Django 4.1.4 on 2024-01-03 13:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('chats', '0009_alter_user_image_user_alter_user_image_table'),
    ]

    operations = [
        migrations.AddField(
            model_name='groups',
            name='image',
            field=models.FileField(blank=True, null=True, upload_to='static/file'),
        ),
        migrations.AlterModelTable(
            name='user_image',
            table='User_Image',
        ),
    ]