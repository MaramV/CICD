#!/bin/bash
export PROJECT_NAME="shoppingcart"
export SWAGGER_PAGE="swagger-ui.html"

#HTTP_CODE=`curl --write-out '%{http_code}' -o /dev/null -m 10 -qsk https://localhost:8443/$PROJECT_NAME/$SWAGGER_PAGE`
HTTP_CODE=`curl --write-out '%{http_code}' -o /dev/null -m 10 -qs http://localhost:8080/$PROJECT_NAME/$SWAGGER_PAGE`

if [ "$HTTP_CODE" == "200" ]; then
  echo "Successfully hit the swagger locally!"
  exit 0;
else
  echo "Server did not resolve swagger file."
  exit 1;
fi
