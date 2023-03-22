#!/bin/bash
export PROJECT_NAME="shoppingcart"
export PROJECT_DIR="shoppingcart-service"

echo "Create output Artifact Directory..."
mkdir -p output/scripts
echo "Copy AppSpec to output..."
cp cicd/appspec.yml output
echo "Copy .sh files to output/scripts..."
cp cicd/*.sh output/scripts
echo "Copy WAR to output..."
cp $PROJECT_DIR/target/*.war output

# Get information from git
LAST_HASH=$(git log -1 --pretty=format:"%H")
AUTHOR_EMAIL=$(git log -1 --pretty=format:'%ae')

# CODEBUILD_BUILD_ID in the format of string:guid
BUILD_PROJ=$(echo $CODEBUILD_BUILD_ID | cut -d ":" -f 1)
BUILD_GUID=$(echo $CODEBUILD_BUILD_ID | cut -d ":" -f 2)

# Zip up the output
echo "Zipping output dir..."
zip $PROJECT_NAME.zip -r output;

ARTIFACT="s3://969702943927-pipeline-artifact/$PROJECT_NAME/$DATE-$TIME-$PROJECT_NAME.zip"

# Push artifact to S3
echo "Push to S3..."
aws s3api put-object \
  --bucket 969702943927-pipeline-artifact \
  --key $PROJECT_NAME/$DATE-$TIME-$PROJECT_NAME.zip \
  --body $PROJECT_NAME.zip \
  --tagging "Project=$PROJECT_NAME&Date=$DATE&Time=$TIME&BuildId=$CODEBUILD_BUILD_ID&GitHash=$LAST_HASH&BuildGuid=$BUILD_GUID&BuildProj=$BUILD_PROJ&GitAuthor=$AUTHOR_EMAIL"
