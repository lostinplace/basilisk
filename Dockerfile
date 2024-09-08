# Use an official Python runtime as a parent image
FROM python:3.11-slim-bullseye

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /basilisk

# Install system dependencies
RUN apt-get update

RUN apt-get install -y \
    build-essential \
    git \
    swig \
    python3-dev \
    python3-tk \
    python3-venv \
    python3-setuptools

RUN rm -rf /var/lib/apt/lists/*

# Clone Basilisk repository
RUN git clone https://github.com/AVSLab/basilisk.git .

# Create and activate virtual environment
RUN python3 -m venv venv


# Copy setup script
COPY setup.sh /basilisk/setup.sh
RUN chmod +x /basilisk/setup.sh

# Run setup script within the virtual environment
SHELL ["/bin/bash", "-c"]
RUN source venv/bin/activate && ./setup.sh

# Set Python path to include Basilisk
ENV PYTHONPATH="${PYTHONPATH}:/basilisk/dist3/basilisk"

# Copy test script
COPY test_basilisk.sh /basilisk/test_basilisk.sh
RUN chmod +x /basilisk/test_basilisk.sh

# Set the default command to run tests
CMD ["/bin/bash", "-c", "source /basilisk/venv/bin/activate && /basilisk/test_basilisk.sh"]
