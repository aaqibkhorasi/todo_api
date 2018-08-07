from tastypie.resources import ModelResource
from tastypie.constants import ALL
from api.models import Todo
from tastypie.authorization import Authorization

class TodoResource(ModelResource):
    class Meta:
        queryset = Todo.objects.all()
        resource_name = 'todo'
        fields = ['todo_text', 'state','due_date']
        authorization = Authorization()
        filtering = {
            "state": ALL,
            "due_date": ALL,
        }