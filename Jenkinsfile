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
    stage('Copy Artifacts to Workspace') {
            steps {
                sh 'cp /var/backups/git-repos/*.tar.gz . || true'
                sh 'cp /var/backups/git-repos/*.txt . || true'
             
              // List files to verify what got copied
                echo '📁 Listing copied artifacts:'
                sh 'ls -lh *.tar.gz *.txt || echo "No files found"'
            }
        }
  }
}
