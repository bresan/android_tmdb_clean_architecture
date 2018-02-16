#!/bin/bash -xe

# Execute JaCoCo Test Report (later deploy to CodeCov.io)
./gradlew clean :data:test :base:test :remote:test :cache:testRelease :domain:test :presentation:test :mobile:testDemoRelease --profile

# Assemble mobile Release artifact
./gradlew :mobile:assembleRelease --stacktrace --no-daemon

# Assemble mobile artifacts for Android Instrumentation Test (later deployed to Firebase Test Lab)
./gradlew :mobile:assembleAndroidTest

# Upload to Firebase Test Lab
openssl aes-256-cbc -K $encrypted_4bc940c959eb_key -iv $encrypted_4bc940c959eb_iv -in TMDBClient-60be7311e0d5.json.enc -out TMDBClient-60be7311e0d5.json -d
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-188.0.1-linux-x86_64.tar.gz
tar xf google-cloud-sdk-188.0.1-linux-x86_64.tar.gz
echo "y" | ./google-cloud-sdk/bin/gcloud components update beta

gcloud config set project tmdbclient

./google-cloud-sdk/bin/gcloud auth activate-service-account --key-file TMDBClient-60be7311e0d5.json

# Upload Mobile Release Artifacts
./google-cloud-sdk/bin/gcloud firebase test android run --type instrumentation --app ./mobile/build/outputs/apk/demo/release/mobile-demo-release.apk --test ./mobile/build/outputs/apk/androidTest/demo/release/mobile-demo-release-androidTest.apk --device model=Nexus5,version=23,locale=en,orientation=portrait
./google-cloud-sdk/bin/gcloud firebase test android run --type instrumentation --app ./mobile/build/outputs/apk/pro/release/mobile-pro-release.apk --test ./mobile/build/outputs/apk/androidTest/pro/release/mobile-pro-release-androidTest.apk --device model=Nexus5,version=23,locale=en,orientation=portrait