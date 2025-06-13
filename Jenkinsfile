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
        sh 'chmod +x Backup_and_audit.sh'
        sh './Backup_and_audit.sh'
      }
    }
  }
}
