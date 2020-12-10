### Setup gcloud CLI
gcloud config set project e516-gcloud-project
gcloud container clusters get-credentials scalable-desktop --region us-central1-a

### Build the desktop image
docker build -t gcr.io/e516-gcloud-project/ubuntu-desktop-lxde-vnc:latest .
docker push gcr.io/e516-gcloud-project/ubuntu-desktop-lxde-vnc

### Deploy desktop app to kubernetes
kubectl create namespace scalable-desktop
helm upgrade --install desktop ./cloud-desktop-chart  \
    --namespace scalable-desktop

# example - deploy the desktop on a GPU nodepool to leverage GPU resource
helm upgrade --install desktop ./cloud-desktop-chart  \
    --namespace scalable-desktop \
    --set nodeSelector.desktop_pool=gpu-pool

