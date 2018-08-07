#!/usr/bin/env bash

CURL_HTTP_ARG="-w httpcode=%{http_code}"
API_URL="http://localhost:8000/api/todo/"

CURL_RETURN_CODE=0
create_response=$(curl "${CURL_HTTP_ARG}" --dump-header - -H "Content-Type: application/json" -X POST --data '{"todo_text": "First", "state":"done","due_date": "2012-05-21"}' "${API_URL}") 2> /dev/null` || CURL_RETURN_CODE=$?;
echo "Single Todo Created ${create_response}"

if [ ${CURL_RETURN_CODE} -ne 0 ]; then
    echo "Curl connection failed with return code - ${CURL_RETURN_CODE}"
else
    echo "Curl connection success"
    # Check http code for curl operation/response in  CURL_OUTPUT
    httpCode=$(echo "${create_response}" | sed -e 's/.*\httpcode=//')
    if [ ${httpCode} -ne 200 ]; then
        echo "Curl operation/command failed due to server return code - ${httpCode}"
    fi
fi

get_response=$(curl -H 'Accept: application/json; indent=4' ${API_URL});
echo "List Received: ${get_response}"

put_response=$(curl --dump-header - -H "Content-Type: application/json" -X PUT --data '{"todo_text": "First_updated", "state":"done","due_date": "2012-05-20"}' http://localhost:8000/api/todo/1/);
echo "Put Response : ${put_response}"

delete_all_response=$(curl --dump-header - -H "Content-Type: application/json" -X DELETE  ${API_URL});
echo "All Resource Empty ${delete_all_response}"
