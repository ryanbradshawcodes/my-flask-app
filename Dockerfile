# Gives Docker a name of another image that we want to use as a base
# for our image
FROM python:3.9

# Install pipenv so we can use it within a container
# Container builds are isolated from the rest of the system
# RUN tells docker to execute a command
RUN pip install pipenv

# Setup working dir within container. Contains have their own file systems separate
# to the computers
WORKDIR /app

# To run our code within the container we need to copy the contents of our project into it
# We copy everything in current dir (our proj dir), docker coins this 'build context', from host
# to the container
COPY . .

# Use pipenv to install dependencies, --system flag installs dependencies to the global
# python environment instead of creating a virtual environment. The container we're in is already
# isolated itself, so no need for virtual env
RUN pipenv install --system


# Now everything for app setup, tell Docker how to run it.
# app:app refers to the Flask aplication 'app' within the file 'app'
# Listen for connections on 0.0.0.0:8080 -> port 8080
CMD gunicorn app:app -b 0.0.0.0:8080



