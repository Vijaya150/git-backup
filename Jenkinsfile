pipeline {
    agent any

    environment {
        BACKUP_DIR = '/var/backups/git-repos'
    }

    stages {
        stage("Git Checkout") {
            steps {
                git "https://github.com/Vijaya150/git-backup.git"
            }
        }

        stage("Backup and Audit") {
            steps {
                sh 'chmod +x Backup_and_audit.sh'
                sh './Backup_and_audit.sh'
            }
        }

     stage("Copy to Workspace for Archiving") {
    steps {
        sh 'cp /var/backups/git-repos/*.tar.gz . || true'
        sh 'cp /var/backups/git-repos/audit_*.txt . || true'
        sh 'ls -lh *.tar.gz audit_*.txt || echo "No files found to archive."'
    }
}
     stage('Archive Artifacts') {
    steps {
        archiveArtifacts artifacts: '*.tar.gz', allowEmptyArchive: true
        archiveArtifacts artifacts: 'audit_*.txt', allowEmptyArchive: true
    }
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
