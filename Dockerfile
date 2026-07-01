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
RUN mkdir -p /run/sshd
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Create root password (change this)
RUN echo 'root:password' | chpasswd

# Expose SSH port
EXPOSE 22

# Copy the repository contents
COPY . /workspace

# Set up Maven
RUN mvn --version

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
