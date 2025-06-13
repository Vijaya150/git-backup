pipeline{
  agent any
  stages{
    stage("git checkout"){
      steps{
        git "https://github.com/Vijaya150/git-backup.git"
      }
    }
    stage("Backup_and_audit"){
      steps{
        chmod +x Backup_and_audit.sh
        ./Backup_and_audit.sh
      }
    }
