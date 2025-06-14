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

                repo_name=(basename "$gitlink" .git)

        if [ -d "$repo_name" ];then
                cd "$repo_name" 
                git pull
                cd ..
                echo "Pulled latest changes"
        else
                git clone "$gitlink"
                echo "git cloned"
        fi

tar -czf ${BACKUP_DIR}/${repo_name}_$(date "+%Y%m%d").tar.gz "$repo_name"
echo "tarball backup is done"

        if [ -d "$repo_name/.git" ];then
                cd "$repo_name" || continue
                git log --since=1.day > "${BACKUP_DIR}/audit_${repo_name}_$(date "+%Y%m%d").txt"

               echo "git logs collected"
               cd ..
       else
               echo "Git repo not found"
        fi

done<"$GITREPO". 
