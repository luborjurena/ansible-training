#!/bin/bash

# Function to create a CentOS container
create_centos_container() {
    local num="$1"
    local user="$2"
    local container_name="${user}-web${num}"
    docker run --name "$container_name" -it -d centos:latest
    echo "Docker CentOS container '$container_name' has been created."
}

# Function to create a Debian container
create_debian_container() {
    local num="$1"
    local user="$2"
    local container_name="${user}-web${num}"
    docker run --name "$container_name" -it -d debian:11
    echo "Docker Debian container '$container_name' has been created."
}

# Function to delete all containers with a specific name prefix
delete_containers() {
    local prefix="$1"
    local containers=$(docker ps -a -q --filter "name=^${prefix}")

    if [ -n "$containers" ]; then
        docker stop $containers
        docker rm $containers
        echo "Deleted containers with the '$prefix' prefix."
    else
        echo "No containers with the '$prefix' prefix found."
    fi
}

# Check for command-line arguments
if [ "$1" == "delete" ]; then
    delete_containers "$(whoami)-web"
    exit
fi

if [ $# -lt 1 ]; then
    echo "Usage: $0 <number_of_containers> [delete]"
    exit 1
fi

num_containers="$1"
user=$(whoami)

for ((i = 1; i <= num_containers; i++)); do
    if [ $((i % 2)) -eq 0 ]; then
        create_centos_container "$i" "$user"
    else
        create_debian_container "$i" "$user"
    fi
done