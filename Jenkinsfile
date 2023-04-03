pipeline {

agent any


parameters {


choice(name: 'TEST_SUITE', choices:['integration_test.xml'], description: 'Test Suite to be executed')
string(name: 'TargetURL', defaultValue: 'https://google.com', description: 'Target base url for test execution')

}

stages {
stage('run integration test') {
steps {

sh "mvn test -Dtestng.suitexml=${params.TEST_SUITE} -Dtest.url.base=${params.TargetURL}"
}
}

}

post{

always {
sh '''client_id="7a129568-94dd-4cc9-a207-bea8a04fff89@986f6ef3-b794-46b5-9afc-473c0d04f649"
client_secret="gXxWJpT2m01MO0QokQ5iky6FVK4xkTX8/burSsfzVfc="
resource="00000003-0000-0ff1-ce00-000000000000/qburst455.sharepoint.com@986f6ef3-b794-46b5-9afc-473c0d04f649"
response=$(curl -X POST \
  https://accounts.accesscontrol.windows.net/986f6ef3-b794-46b5-9afc-473c0d04f649/tokens/OAuth/2/ \
  -H 'Content-Type: multipart/form-data' \
  -F 'grant_type=client_credentials' \
  -F 'client_id=$client_id' \
  -F 'client_secret=$client_secret' \
  -F 'resource=$resource')

access_token=$(echo $response | jq -r '.access_token')

curl --location "https://qburst455.sharepoint.com/sites/DemoSiteForJenkins/_api/Web/GetFolderByServerRelativeUrl('/sites/DemoSiteForJenkins/Shared%20Documents/Reports')/files/add(url='SampleHtml.zip',overwrite=true)" \
--header "Authorization: Bearer $access_token" \
--header "Accept: application/json;odata=verbose" \
--header "Content-Type: application/octet-stream" \
--data-binary "${WORKSPACE}/target/surefire-reports/SampleHtml.zip"
'''

}
}

}