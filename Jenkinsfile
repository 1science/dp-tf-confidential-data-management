pipeline {
  environment {
    TAG = VersionNumber(versionNumberString: '${BUILDS_ALL_TIME_Z}', versionPrefix: '1.', worstResultForIncrement: "SUCCESS")
  }
  stages {
    stage('Spinnaker-Webhook') {
      agent {
        label 'kubernetes'
      }
      steps {
        container('kubectl-slave') {
            spinnakerWebhook (
                pipelineName: "dp-tf-confidential-data-management",
                helmTag: "",
                helmName: "dp-tf-confidential-data-management",
                imageTag: env.TAG,
                imageName: "dp-tf-confidential-data-management"
            )
        }
      }
    }
  }
}
