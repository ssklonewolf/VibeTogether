#before running this need to make this file executable in your system
# in your bash or terminal type
# chmod +x Intial-Folder-Create.sh

# replace SSK with your name
mkdir SSK && cd SSK 
mkdir -p Terraform  && touch Terraform/main.tf
mkdir -p Docker && touch Docker/Dockerfile
mkdir -p Kubernetes && touch Kubernetes/pod.yaml
mkdir -p Misc && touch Misc/self-notes.txt