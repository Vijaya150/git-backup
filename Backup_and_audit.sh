#!/bin/bash

GITREPO="gitrepolink.txt"
BACKUP_DIR="/var/backups/git-repos"

mkdir -p "$BACKUP_DIR"
chmod -R 770 "$BACKUP_DIR"

while read -r gitlink;do
        if [ -z "$gitlink" ];then
                echo "link is empty"
        continue
        fi
           repo_name=`(basename "$gitlink" .git)`

        if [ -d "$repo_name" ];then
                cd "$repo_name" 
                git pull
                cd ..
                echo "Pulled latest changes"
        else
                git clone "$gitlink"
                echo "git cloned"
        fi

 cp -r "$repo_name" "$TEMP_DIR/"

    # Collect audit logs in one file
    if [ -d "$repo_name/.git" ]; then
        cd "$repo_name" || continue
        git log --since=1.day >> "${BACKUP_DIR}/audit_$(date "+%Y%m%d").txt"
        echo "Git logs collected"
        cd ..
    else
        echo "Git repo not found"
    fi

done < "$GITREPO"

# Tar all repos into one file
tar -czf "${BACKUP_DIR}/git-tarfile_$(date "+%Y%m%d").tar.gz" -C "$TEMP_DIR" .
