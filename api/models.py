from django.db import models


class Todo(models.Model):
    todo_text = models.CharField(max_length=200)
    state = models.TextField()
    due_date = models.DateField()

    def __str__(self):
        return self.todo_text