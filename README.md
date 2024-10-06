# Environment Setup

Before running the script, ensure you have the required environment variables set up. You can do this by adding the following lines to your '.bashrc' file.

```
export AZURE_STORAGE_ACCOUNT=<your-storage-account-name>
export AZURE_STORAGE_KEY=<your-storage-key>
```
Save the file, exit, and reload the .bashrc file.
```
source ~/.bashrc
```

# Azure Uploader Script

This is a simple Bash script for uploading files to Azure Blob Storage.

## Usage

Run the script using the following syntax:

```bash
./azure_uploader.sh <container_name> <file_path>
```

## Example

```bash
./azure_uploader.sh my-container /path/to/myfile.txt