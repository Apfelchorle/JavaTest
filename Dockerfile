FROM openjdk:21-slim

WORKDIR /workspace

# Install build tools and Git
RUN apt-get update && apt-get install -y \
    maven \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy the repository contents
COPY . /workspace

# Set up Maven
RUN mvn --version

CMD ["/bin/bash"]
