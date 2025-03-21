docker pull rohankamble103/demo-codepipeline:latest

#docker run -itd -p 90:80 rohankamble103/demo-codepipeline:latest


#!/bin/bash

PORT=90
IMAGE_NAME="rohankamble103/demo-codepipeline:latest"
CONTAINER_NAME="codepipeline"

# Check if port is in use
if sudo lsof -i :$PORT | grep LISTEN; then
    echo "Port $PORT is in use. Stopping the existing container..."

    # Find the container using the port and stop it
    CONTAINER_ID=$(docker ps --format '{{.ID}} {{.Ports}}' | grep ":$PORT" | awk '{print $1}')

    if [ ! -z "$CONTAINER_ID" ]; then
        docker stop "$CONTAINER_ID"
        docker rm "$CONTAINER_ID"
        echo "Stopped and removed container $CONTAINER_ID"
    else
        echo "No container found using port $PORT"
    fi
else
    echo "Port $PORT is free. Proceeding to start the new container..."
fi

# Start a new container
echo "Starting a new container..."
docker run -itd -p $PORT:80 --name $CONTAINER_NAME $IMAGE_NAME

# Verify if the container started
if [ $? -eq 0 ]; then
    echo "Container started successfully!"
else
    echo "Failed to start the container."
fi

