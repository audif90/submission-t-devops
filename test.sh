#!/bin/bash

post_request(){
echo -e '\e[42mTesting POST request\e[49m'
echo -e '\n'
echo -e '\e[42mUsing contactNumber: 1, contactName: Audi\e[49m'

curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"contactNumber": 1,"contactName":"Audi"}' \
  http://localhost:8080/contact
echo -e '\n'
sleep 3
}

get_request_all(){
echo -e '\e[42mTesting GET to All data request\e[49m'
curl --header "Content-Type: application/json" \
  http://localhost:8080/contact
echo -e '\n'
sleep 3
}

put_request(){
echo -e '\e[42mTesting PUT/update request\e[49m'
echo -e '\e[42mUpdating contactName to James\e[49m'

curl --header "Content-Type: application/json" \
  --request PUT \
  --data '{"contactNumber": 1,"contactName":"James"}' \
  http://localhost:8080/contact/1
echo -e '\n'
sleep 3
}

get_specific_request(){
echo -e '\e[42mTesting GET to specific data request\e[49m'

curl --header "Content-Type: application/json" \
  http://localhost:8080/contact/1
echo -e '\n'
sleep 3
}

delete_request(){
echo -e '\e[42mTesting DELETE request\e[49m'

curl --header "Content-Type: application/json" \
  --request DELETE \
  http://localhost:8080/contact/1
echo -e '\n'
sleep 3
}

#
#===========================================
# Main

clear # Cleaning the screen
echo -e '\e[42mAutomation Script for API testing with CURL\e[49m'
echo -e '\n'

# Running steps!
post_request
get_request_all
put_request
get_specific_request
delete_request
echo -e '\e[42mRechecking if Datastore is empty\e[49m'
get_request_all