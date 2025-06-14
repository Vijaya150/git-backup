pipeline {
  agent any
         
  environment {
        BACKUP_DIR = '/var/backups/git-repos'

  
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
                // Archive backups and audit logs from /var/backups/git-repos
                archiveArtifacts artifacts: '/var/backups/git-repos/*.tar.gz', allowEmptyArchive: true
                archiveArtifacts artifacts: '/var/backups/git-repos/audit_*.txt', allowEmptyArchive: true
            }
        }

    post {
        always {
            echo '=== Git Audit Summary ==='
            sh 'cat /var/backups/git-repos/audit_*.txt || echo "No audit logs found."'
        }
        success {
            echo '✅ Backup and audit completed successfully.'
        }
        failure {
            echo '❌ Backup or audit failed. Check the logs for more details.'
        }
    }
}
