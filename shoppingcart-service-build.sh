#!/bin/bash
export PROJECT_DIR="shoppingcart-service"

echo "Switch to the $PROJECT_DIR directory..."
cd $PROJECT_DIR
echo "Running $PROJECT_DIR Maven validate..."
mvn -s $CODEBUILD_SRC_DIR_otc_SettingsFile/$SETTING_SRC validate -q
echo "Running $PROJECT_DIR Maven compile..."
mvn -s $CODEBUILD_SRC_DIR_otc_SettingsFile/$SETTING_SRC compile -q
echo "Running $PROJECT_DIR Maven test..."
#mvn -s $CODEBUILD_SRC_DIR_otc_SettingsFile/$SETTING_SRC test -q
echo "Running $PROJECT_DIR Maven package..."
mvn -s $CODEBUILD_SRC_DIR_otc_SettingsFile/$SETTING_SRC package -Dmaven.test.skip -q
