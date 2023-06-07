# Uses the latest Nginx image as the base image
FROM nginx:latest

# Sets the default value for the USERNAME argument
ARG USERNAME=nginx

# Switches to the root user
USER root

# Copies the server.c file to the user's home directory
COPY ./server.c /home/$USERNAME/server.c

# Copies the script.sh file to the user's home directory
COPY ./script.sh /home/$USERNAME/script.sh

# Copies the Nginx configuration file to the appropriate location
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

# Updates the package list
RUN apt-get update ; \
    # Installs the necessary packages for building and running a FastCGI server
    apt-get install -y gcc spawn-fcgi libfcgi-dev ; \
    # Cleans the package cache
    apt-get clean ; \
    # Removes the package cache
    rm -rf /var/lib/apt/lists/*

# Sets the working directory to the user's home directory
WORKDIR /home/$USERNAME

# Adds the user to the adm, root, and nginx groups
RUN usermod -aG adm,root,nginx $USERNAME; \
    # Changes ownership of the Nginx cache directory
    chown -R $USERNAME:$USERNAME /var/cache/nginx/ ; \
    # Changes ownership of the run directory
    chown -R $USERNAME:$USERNAME /var/run/ ; \
    # Changes ownership of the home directory
    chown -R $USERNAME:$USERNAME /home/$USERNAME/ ; \
    # Makes the script executable
    chmod +x /home/$USERNAME/script.sh

# Switches back to the non-root user
USER $USERNAME

 # Disables the health check
HEALTHCHECK NONE

# Sets the entry point for the container to the script.sh file
ENTRYPOINT ["sh", "./script.sh"]
