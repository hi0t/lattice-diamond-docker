# Lattice Diamond Docker Image

This repository contains the Dockerfile for building a Docker image containing Lattice Diamond 3.14.

The image is designed to be used in CI/CD pipelines and for local development where a consistent environment is needed.

## Usage

### Building locally

```bash
docker build -t ghcr.io/hi0t/lattice-diamond-docker:latest .
```

### Running

To run the container, you need to mount your project directory and the license file.

The container includes an entrypoint script that automatically sets up a user matching the provided UID/GID (default 1000:1000). This ensures file permissions on mounted volumes are correct and is required for correct execution of Lattice Diamond.

```bash
docker run --rm -it \
  -e USER_UID=$(id -u) \
  -e USER_GID=$(id -g) \
  -v $(pwd):/workspace \
  -v /path/to/license.dat:/diamond/license/license.dat:ro \
  ghcr.io/hi0t/lattice-diamond-docker:latest \
  bash
```

## License

See LICENSE file.
