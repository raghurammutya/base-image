#!/bin/bash

# Configuration
TOKEN="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"   # ⚠️ Keep this secret
USERNAME="raghurammutya"
IMAGE_NAME="base-image"
IMAGE_TAG="latest"
GHCR_IMAGE="ghcr.io/$USERNAME/$IMAGE_NAME:$IMAGE_TAG"
DOCKERFILE_PATH="."  # or specify path like "./Dockerfile.base"

# Step 1: Build the Docker image
echo "📦 Building Docker image: $IMAGE_NAME:$IMAGE_TAG ..."
docker build -t "$IMAGE_NAME:$IMAGE_TAG" "$DOCKERFILE_PATH" || {
    echo "❌ Docker build failed"
    exit 1
}

# Step 2: Login to GitHub Container Registry
echo "🔐 Logging into ghcr.io ..."
echo "$TOKEN" | docker login ghcr.io -u "$USERNAME" --password-stdin || {
    echo "❌ Docker login failed"
    exit 1
}

# Step 3: Tag the image for GHCR
echo "🏷️ Tagging image as $GHCR_IMAGE ..."
docker tag "$IMAGE_NAME:$IMAGE_TAG" "$GHCR_IMAGE"

# Step 4: Push the image to GHCR
echo "🚀 Pushing image to GHCR ..."
docker push "$GHCR_IMAGE" || {
    echo "❌ Docker push failed"
    exit 1
}

echo "✅ Image pushed successfully: $GHCR_IMAGE"
