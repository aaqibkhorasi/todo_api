#!/bin/bash

API_URL="http://localhost:8000/api/todo/"
data='{"todo_text": "First", "state":"done","due_date": "2012-05-21"}'
delete_all_response=$(curl -s --dump-header - -H "Content-Type: application/json" -X DELETE  ${API_URL});

create_response=$(curl -s -H "Content-Type: application/json" -X POST --data "${data}" "${API_URL}");
echo "----Create Test Started----"
echo "Creates single todo resource and expects single resource to be created"

get_response=$(curl -s -H 'Accept: application/json' ${API_URL} | jq '.["objects"]');
res_length=`echo $get_response | jq '. | length'`
res_text=`echo $get_response | jq -r '.[]["todo_text"]'`

echo $get_response | jq .

if [ "${res_length}" -eq 1 ] && [ "${res_text}" == "First" ]; then
    echo "Test Case # 1 (CREATE): Passed"
fi

echo "----Get Test Started----"
echo "Expects list of todos"
get_response=$(curl -s -H 'Accept: application/json' ${API_URL} | jq '.["objects"]');
res_length=`echo $get_response | jq '. | length'`
res_text=`echo $get_response | jq -r '.[]["todo_text"]'`
echo $get_response | jq .
if [ "${res_length}" -eq 1 ] && [ "${res_text}" == "First" ]; then
    echo "Test Case # 2 (GET): Passed"
fi

echo "----Put Test Started----"
echo "Test to see if exisiting todo resource's todo_text is updated to First_updated"
resource_uri=`echo $get_response | jq -r '.[]["resource_uri"]'`

put_response=$(curl -s -H "Content-Type: application/json" -X PUT --data '{"todo_text": "First_updated", "state":"done","due_date": "2012-05-20"}' http://localhost:8000"${resource_uri}" | jq '.["objects"]');
get_response=$(curl -s -H 'Accept: application/json' ${API_URL} | jq '.["objects"]');
res_length=`echo $get_response | jq '. | length'`
res_text=`echo $get_response | jq -r '.[]["todo_text"]'`
echo $get_response | jq .
if [ "${res_length}" -eq 1 ] && [ "${res_text}" == "First_updated" ]; then
    echo "Test Case # 3 (PUT): Passed"
fi

echo "----Filter Test Started----"
echo 'Test the filter query on state=done and due_date="2012-05-20"'
filter_response=$(curl -s -H 'Accept: application/json' "${API_URL}"?format=json&due_date="2012-05-20"&state="done")
filter_response=$(echo $filter_response| jq '.["objects"]')
res_length=`echo $filter_response | jq -r '. | length'`
res_text=`echo $filter_response | jq -r '.[]["state"]'`
res_text_due_date=`echo $filter_response | jq -r '.[]["due_date"]'`
echo $get_response | jq .
if [ "${res_length}" -eq 1 ] && [ "${res_text}" == "done" ] && [ "${res_text_due_date}" == "2012-05-20" ]; then
    echo "Test Case # 4 (FILTER): Passed"
fi

echo "----Delete All Test Started----"
delete_all_response=$(curl -s --dump-header - -H "Content-Type: application/json" -X DELETE  ${API_URL});
get_response=$(curl -s -H 'Accept: application/json' ${API_URL} | jq '.["objects"]');
res_length=`echo $get_response | jq '. | length'`
res_text=`echo $get_response | jq -r '.[]["todo_text"]'`
echo $get_response | jq .
if [ "${res_length}" -eq 0 ]; then
    echo "Test Case # 5 (DELETE): Passed"
fi
