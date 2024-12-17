# Use an official Python runtime as a parent image.
#FROM python:3.12.4-slim
FROM docker.cloudsmith.io/demo/gh-actions/python:3.12.4-slim

# Set the working directory in the container.
WORKDIR /flask_app

# Copy the current directory contents into the container at /flask_app.
COPY flask_app/app.py /flask_app
COPY flask_app/requirements.txt /flask_app

ENV CLOUDSMITH_API_KEY
ENV CLOUDSMITH_SERVICE
ENV CLOUDSMITH_REPO_NAME
ENV CLOUDSMITH_NAMESPACE

# Set the PIP_INDEX_URL environment variable.
ENV PIP_INDEX_URL=--https://${CLOUDSMITH_SERVICE}:${CLOUDSMITH_API_KEY}@dl.cloudsmith.io/basic/demo/gh-actions/python/simple/

# Install any needed packages specified in requirements.txt using the Cloudsmith repository.
RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Run app.py when the container launches
CMD ["python", "app.py"]
