# todo_api
Todo_api

- Clone the project
- cd to main directory and run pip install requirement.txt
- Run python manage.py migrate --run-syncdb
- Run python manage.py makemigrations
- Run python manage.py migrate
- Run python manage.py runserver    (This is will start the server)

Test Script : test_script.sh
On mac : 
- Install jq tool by running 'brew install jq' command

On Ubuntu: 
It is possible to perform sudo apt-get install jq however you need to inform the system where to find jq.

1) Open your sources file in a text editor:

'sudo vim /etc/apt/sources.list'
Add the following line to the end of that file (note deb is not a command, more info):

deb http://us.archive.ubuntu.com/ubuntu vivid main universe

2) Then re-index apt-get so that it can find jq:

'sudo apt-get update'

3)Then do the normal install and you should be the proud new user of jq!

'sudo apt-get install jq'

Instruction Link: https://stackoverflow.com/questions/33184780/install-jq-json-processor-on-ubuntu-10-04

On terminal, run this script by writting ./test_script.sh


Test Cases Coverage: 
- Create Todo
- Get Todo list
- Put Todo (updates existing todo)
- Delete todos 


Here is the list of Curl Commands : 

Retreive all todo list
curl -H 'Accept: application/json; indent=4' http://localhost:8000/api/todo/

Retreive Single todo
Retreive all todo list
curl -H 'Accept: application/json; indent=4' http://localhost:8000/api/todo/<ID>/

Create Object (Single)
curl --dump-header - -H "Content-Type: application/json" -X POST --data '{"todo_text": "First", "state":"done","due_date": "2012-05-21"}' http://localhost:8000/api/todo/

Create (Multiple)
curl --dump-header - -H "Content-Type: application/json" -X PATCH --data '{"objects": [{"todo_text": "First", "state":"done","due_date": "2012-05-21"},{"todo_text": "Second", "state":"done","due_date": "2012-05-22"}], "deleted_objects": []}'  http://localhost:8000/api/todo/

PUT (Single)
curl --dump-header - -H "Content-Type: application/json" -X PUT --data '{"todo_text": "First_updated", "state":"done","due_date": "2012-05-20"}' http://localhost:8000/api/todo/1/

PUT (Multiple)
curl --dump-header - -H "Content-Type: application/json" -X PUT --data '{"objects": [{"todo_text": "first_updated_1","id": "1","due_date": "2011-05-06", "state":"done"},{"todo_text": "second_updated","id": "2","due_date": "2012-06-06","state":"todo"}]}' http://localhost:8000/api/todo/

Filter :
http://localhost:8000/api/todo/?format=json&state=done

Delete (Single)
curl --dump-header - -H "Content-Type: application/json" -X DELETE  http://localhost:8000/api/todo/1/

Delete (multiple:
curl --dump-header - -H "Content-Type: application/json" -X DELETE  http://localhost:8000/api/todo/
