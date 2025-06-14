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
    stage('Archive Artifacts') {
            steps {
              archiveArtifacts artifacts: '"${BACKUP_DIR}/*.tar.gz, ${BACKUP_DIR}/*.txt"', followSymlinks: false
            }
    }
  }
}
