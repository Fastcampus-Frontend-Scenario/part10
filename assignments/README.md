# 목적

AWS 인프라스트럭쳐 환경에서의 Next.js 프로젝트 CI/CD 환경을 구성

# 요구사항

AWS 환경 구성에 대한 architecture diagram 구현

- GitHub repository를 포함한, 사용되는 AWS 서비스 들과 서로간의 관계를 다이어그램으로 나타냅니다.

Next.js 프로젝트는 Dockerize 되어서 AWS ECR에 push되어야 합니다.

- Next.js 프로젝트의 `Dockerfile`은 <https://github.com/vercel/next.js/blob/canary/examples/with-docker/Dockerfile> 경로의 파일 내용을 이용합니다.
- Image size 감소를 위해 `next.config.js` 파일에 `output: ‘standalone’` 항목이 추가되어야 합니다.

AWS ECR push 이후,  deployment 가 수행될 script가 작성되어야 합니다.

- 스크립트 파일명은  `deploy.sh` 로 명명
- 해당 스크립트는 압축되어서 s3 로 업로드 되어야 합니다.

AWS CodeDeploy를 통해서 해당 스크립트가 수행되도록 합니다.

- CodeDeploy를 수행하는 AWS cli 명령여는 다음과 같습니다.

```
aws deploy create-deployment --application-name CodeDeploy <CodeDeploy_APP_NAME> \
--deployment-config-name CodeDeployDefault.OneAtATime \
--deployment-group-name <CodeDeploy_DEPLOYMENT_GROUP_NAME> \
--s3-location bucket=<S3_BUCKET_NAME>,bundleType=zip,key=<ZIP_FILE_NAME>
```

EC2 인스턴스 에는 docker가 사전 설치 되어 있어야 합니다.

- <https://docs.aws.amazon.com/AmazonECR/latest/userguide/getting-started-cli.html> 의 도커 설치 부분을 참조하셔서 구성하시면 됩니다.

GitHub에서 사용하는 IAM role은 다음의 권한이 필요합니다.

- S3에 put 권한
- ECR push 권한
- CodeDeploy create deploy 권한

EC2 에서 사용되는 IAM role은 다음의 권한이 필요합니다.

- s3의 object 를 get, list
- ECR image list, read

## 추가 과제

추가 과제는 별도의 설명이 없습니다.

스스로 진행하시면 되고, 필요시 피드백이 진행될 수 있습니다.

- AutoScalingGroup 를 활용한 로드밸런싱을 진행하셔도 좋습니다.
- Blue/Green 정책을 이용한 무중단 배포를 진행해 보셔도 좋습니다.
