# Generated by Django 4.1.4 on 2024-01-04 11:17

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('chats', '0011_alter_groups_image'),
    ]

    operations = [
        migrations.AlterField(
            model_name='groups',
            name='image',
            field=models.FileField(blank=True, null=True, upload_to='static/file'),
        ),
    ]
