# Using python:3.9-slim-buster as the base image
FROM python:3.9-slim-buster

# Accept GH_PAT as a build argument
ARG GH_PAT
ARG GITHUB_ACTOR

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Update system packages and install git
RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# Set up .netrc file for authentication with GitHub to access private repositories
RUN echo "machine github.com login $GITHUB_ACTOR password $GH_PAT" > ~/.netrc && \
    chmod 600 ~/.netrc

# Install any needed packages specified in requirements.txt
RUN pip3 install --trusted-host pypi.python.org -r requirements.txt

# Clean up .netrc after installation to ensure the token isn't left in the image
RUN rm ~/.netrc

# Command to run when starting the container
CMD ["python3", "run.py"]
