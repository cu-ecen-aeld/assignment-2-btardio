#!/bin/sh

# Delete existing installations
apt-get remove docker docker-engine docker.io containerd runc

# Set up repos
apt-get update
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

# Install docker engine
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Add yourself to group

adduser docker

# usermod -aG docker $USER



echo "Please log out and back in for changes to take effect.  Then, run the following"
echo "commands to test your installation:"
cat << EOF
docker run hello-world
EOF
