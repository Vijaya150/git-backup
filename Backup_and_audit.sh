#!/bin/bash

GITREPO="gitrepolink.txt"

sudo mkdir -p /var/backups/git-repos/
sudo chmod -R 770 /var/backups/git-repos/

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

sudo tar -czf /var/backups/git-repos/${repo_name}_$(date "+%Y%m%d").tar.gz "$repo_name"
echo "tarball backup is done"

	if [ -d "$repo_name/.git" ];then
		cd "$repo_name" || continue
		git log --since=1.day | sudo tee /var/backups/git-repos/audit_${repo_name}_$(date "+%Y%m%d").txt > /dev/null

               echo "git logs collected"
	       cd ..
       else
	       echo "Git repo not found"
	fi

done<"$GITREPO"


