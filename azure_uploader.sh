#!/bin/bash

# Instructions on how to execute the script
usage() {
    echo "Usage $0 <container-name> <file-path>"
}

#Check if the correct number of arguments were passed
if [ "$#" -ne 2 ]; then
    usage
fi

#Assign variables to args
CONTAINER_NAME=$1
FILE_PATH=$2
BLOB_NAME=$(basename "$FILE_PATH")

#Checks if the file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File $FILE_PATH not found"
    exit 1
fi

#uplad file to Azure
echo "Uploading $FILE_PATH to container $CONTAINER..."

az storage blob upload --account-name $AZURE_STORAGE_ACCOUNT --container-name $CONTAINER_NAME --file $FILE_PATH --name $BLOB_NAME --auth-mode key

if [ $? -eq 0 ]; then 
    echo "Successfully uploaded file to Azure Blob Storage."

    read -p "Do you want to generate a SAS Token for this file? (yes/no): " generate_sas

    if [ "$generate_sas" == "yes" ]; then
        sas_token=$(az storage blob generate-sas --account-name $AZURE_STORAGE_ACCOUNT --container-name $CONTAINER_NAME --name $BLOB_NAME --permissions r --expiry $(date -u -d "1 hour" '+%Y-%m-%dT%H:%MZ') --auth-mode key --output tsv)

        #Generate URL with SAS token
        blob_url="https://$AZURE_STORAGE_ACCOUNT.blob.core.windows.net/$CONTAINER_NAME/$BLOB_NAME?$sas_token"
        #Output URL
        echo "The file can be accessed at: $blob_url"
    else
        echo "SAS Token generation skipped."
    fi

else
    echo "Error occurred during upload."
    exit 1
fi
