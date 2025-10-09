FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Create metalgo user
RUN useradd -m -s /bin/bash metalgo

# Download and install MetalGo
WORKDIR /tmp
RUN wget https://github.com/MetalBlockchain/metalgo/releases/download/v1.12.0-hotfix/metalgo-linux-amd64-v1.12.0-hotfix.tar.gz && \
    tar -xzf metalgo-linux-amd64-v1.12.0-hotfix.tar.gz && \
    mv metalgo-v1.12.0-hotfix/metalgo /usr/local/bin/ && \
    chmod +x /usr/local/bin/metalgo && \
    rm -rf metalgo-v1.12.0-hotfix metalgo-linux-amd64-v1.12.0-hotfix.tar.gz

# Create data directory
RUN mkdir -p /root/.metalgo && \
    chown -R metalgo:metalgo /root/.metalgo

# Switch to metalgo user
USER metalgo
WORKDIR /home/metalgo

# Copy startup script
COPY --chown=metalgo:metalgo scripts/start-metal-node.sh /home/metalgo/
RUN chmod +x /home/metalgo/start-metal-node.sh

# Expose ports
EXPOSE 9650 9651

# Start MetalGo
CMD ["/home/metalgo/start-metal-node.sh"]