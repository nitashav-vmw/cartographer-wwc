#Simple flow source>image>deploy

##Manual flow with (Carto)

yq 01-fluxcd-gitrepo.yaml 01-kpack-build.yaml 01-knative-service.yaml

yq 01-fluxcd-gitrepo-values.yaml

k apply -f 01-fluxcd-gitrepo-values.yaml

k get gitrepository.source.toolkit.fluxcd.io/carto-java-web-app-wwc -o yaml| yq .status.url

vi 01-kpack-build-values.yaml

k apply -f  01-kpack-build-values.yaml

k get image.kpack.io/carto-java-web-app-wwc -o yaml|yq -

kp build logs carto-java-web-app-wwc

k get image.kpack.io/carto-java-web-app-wwc -o yaml|yq .status.latestImage

vi 01-knative-service-values.yaml

k apply -f 01-knative-service-values.yaml

k get service.serving.knative.dev/carto-java-web-app-wwc
k get po

##
##Clean up

k delete service.serving.knative.dev/carto-java-web-app-wwc
k delete image.kpack.io/carto-java-web-app-wwc
k delete gitrepository.source.toolkit.fluxcd.io/carto-java-web-app-wwc

cd ../02

## Carto Templates
k get crd|grep carto|grep template

yq 02-template-source.yaml

yq 02-template-image.yaml

yq 02-template-delivery.yaml

yq 02-supply-chain.yaml

cd ../03
yq 03-parameterized-source.yaml 03-parameterized-image.yaml
yq 03-supply-chain.yaml


k apply -f 03-workload.yaml

k get po
kp build logs tanzu-java-web-app-wwc
kp build status tanzu-java-web-app-wwc --bom| jq
k tree workload tanzu-java-web-app-wwc

k get service.serving.knative.dev/tanzu-java-web-app-wwc

k apply -f 03-workload-dotnet.yaml
k get po
k tree workload tanzu-dotnet-web-app-wwc created
kp build logs tanzu-dotnet-web-app-wwc
k tree workload tanzu-dotnet-web-app-wwc created
k get service.serving.knative.dev/tanzu-dotnet-web-app-wwc










