# Base image
FROM      python:3.6-stretch

# Update system (container) and install necessary utilites
RUN       apt-get update && apt install -y \
          apt-utils \
          python3-pip \
          python3-dev \
          && rm -rf /var/lib/apt/lists/*

# Upgrade pip, install virtualenv and other packages
RUN       pip3 install --upgrade pip \
          &&  pip3 install virtualenv

          # Install additional python packages if necessary. Uncomment lines with packages you need
          # &&  pip3 install mysql-connector \
          # &&  pip3 install tabulate

# Create a user with home directory
RUN       useradd -ms /bin/bash jupyter-user

ARG       service_user
RUN       RUN useradd -ms /bin/bash $service_user


# Switch to non-root user
USER      jupyter-user

# Change working directory again
WORKDIR   /home/jupyter-user

# Create necessary direcories
RUN       mkdir -p ./jupyter-project/certs \
          && mkdir ./jupyter-project/notebook \
          && mkdir .jupyter

# Change working directory
WORKDIR   jupyter-project

ENV       PATH="/home/jupyter-user/.local/bin:${PATH}"

# Set the virtual environment and install Jupyter Notebook
RUN       virtualenv jupyter-virtualenv \
	        && /bin/bash -c "source jupyter-virtualenv/bin/activate" \
          && pip install jupyter


# Generating certificates for secure communication
RUN       openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout "certs/jupyter.key" -out "certs/jupyter.pem" -batch

# Expose Jupyter Notebook default port
EXPOSE    8888

# Generate hashed password
RUN	      echo "c.NotebookApp.password = u'$(python pass.py)'" | tee -a ../.jupyter/jupyter_notebook_config.py

CMD       ["jupyter","notebook"]
