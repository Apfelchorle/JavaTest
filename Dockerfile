FROM openjdk:21-slim

WORKDIR /workspace

# Install build tools, Git, and SSH
RUN apt-get update && apt-get install -y \
    maven \
    git \
    curl \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Set up SSH
RUN mkdir -p /run/sshd /root/.ssh
RUN chmod 700 /root/.ssh

# Configure SSH for key-based authentication
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# Copy your public SSH key into the container
# Replace with your actual public key
COPY id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

# Expose SSH port
EXPOSE 22

# Copy the repository contents
COPY . /workspace

# Set up Maven
RUN mvn --version

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
