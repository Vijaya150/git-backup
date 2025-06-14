#!/bin/bash

GITREPO="gitrepolink.txt"
BACKUP_DIR="/var/backups/git-repos"

# Create backup directory with appropriate permissions
mkdir -p "$BACKUP_DIR"
chmod -R 770 "$BACKUP_DIR"

# Read each line (repo URL) from the file
while read -r gitlink; do
    # Skip empty lines
    if [ -z "$gitlink" ]; then
        echo "Link is empty, skipping..."
        continue
    fi

    # Extract repository name from the URL
    repo_name=$(basename "$gitlink" .git)

    if [ -d "$repo_name" ]; then
        echo "Repository '$repo_name' already exists. Pulling latest changes..."
        cd "$repo_name" || continue
        git pull
        cd ..
    else
        echo "Cloning repository '$gitlink'..."
        git clone "$gitlink"
    fi

    # Create a tar.gz backup
    tarball="${BACKUP_DIR}/${repo_name}_$(date "+%Y%m%d").tar.gz"
    tar -czf "$tarball" "$repo_name"
    echo "Tarball backup created at $tarball"

    # Collect git logs for the past day
    if [ -d "$repo_name/.git" ]; then
        cd "$repo_name" || continue
        audit_log="${BACKUP_DIR}/audit_${repo_name}_$(date "+%Y%m%d").txt"
        git log --since=1.day > "$audit_log"
        echo "Git logs for last 1 day saved to $audit_log"
        cd ..
    else
        echo "Directory '$repo_name' is not a valid Git repository."
    fi

done < "$GITREPO"
