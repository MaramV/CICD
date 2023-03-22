#!/bin/bash
# Copy application from tmp to opt directory
# Write out context XML file
export PROJECT_NAME="shoppingcart"
export BUILD_WAR="shoppingcart-service*.war"

export TEMP_FOLDER="/tmp/tomcat/$PROJECT_NAME"
export WAR_FILE=$(basename $TEMP_FOLDER/$BUILD_WAR)
export TOMCAT_ROOT="/usr/share/tomcat"
export CONF_FILE="/conf/Catalina/localhost/$PROJECT_NAME.xml"
export WAR_DIR="/opt/tomcat/$DEPLOYMENT_ID"

mkdir -p $WAR_DIR
cp $TEMP_FOLDER/$WAR_FILE $WAR_DIR/$WAR_FILE

# Running systemctl stop tomcat does not throw errors if it's stopped
systemctl stop tomcat

echo "<Context path=\"/$PROJECT_NAME\" docBase=\"$WAR_DIR/$WAR_FILE\" />" > $TOMCAT_ROOT/$CONF_FILE
chown tomcat:tomcat $TOMCAT_ROOT/$CONF_FILE

sleep 60;
