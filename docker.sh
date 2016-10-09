#!/bin/bash

##################################################
# CONFIGURATION
##################################################
# docker version
DOCKER_MIN_VERSION=1.12.1
DOCKER_VERSION=$(docker version | grep "Version" | head -1 | tr -d ' ' | cut -d':' -f2)

# docker ids
IMAGE=savethecode-angular2
CONTAINER=savethecode-angular2

# ports
PORT_HOST=8080
PORT_GUEST=8080

# sources
PATH_HOST_SOURCES=$(pwd)
PATH_GUEST_SOURCES=/src/savethecode

# application
DOMAIN=docker.savethecode.angular2
DOMAIN_IP=127.0.0.1

# repository with my personal environment settings
REPOSITORY_ENVIRONMENT=git@github.com:alber999/environment.git

# tmp directory
PATH_TMP=tmp
FILE_TMP_BASHRC=$PATH_TMP/.bashrc
PATH_TMP_ENV=$PATH_TMP/env

# alias to add to .bashrc whatever its content is
# use quotation marks " in values
BASHRC_ALIAS=(
    "PS1='(docker) '\$PS1"
    "alias log='tail -f /var/log/savethecode/angular2.log'"
    "alias logc='grc tail -f /var/log/savethecode/angular2.log'"
)

# these files must be copied in Dockerfile (sample: COPY /tmp/.bashrc /root/) or won't be in container
# don't use quotation marks " or ' in values
FILES_TO_DOCKER=(
    ~/.ssh/github_rsa
    ~/.ssh/github_rsa.pub
    $PATH_TMP_ENV/.bashrc
    $PATH_TMP_ENV/.gitconfig
)

##################################################
# LOG FUNCTIONS
##################################################
function log_banner() {
    echo -e "\033[42m$1\033[00m"
}

function log_info() {
    echo -e "\033[32mINFO: $1\033[00m"
}

function log_warning() {
    echo -e "\033[33mWARNING: $1\033[00m"
}

function log_error() {
    echo -e "\033[31mERROR: $1\033[00m"
}

##################################################
# GENERAL FUNCTIONS
##################################################
function copy_to_tmp() {
    mkdir -p tmp

    if [ -f $1 ]; then
        log_info "- $(basename $1)"
        cp $1 $PATH_TMP/.
    else
        log_warning "- $(basename $1): not found. Empty file created"
        touch tmp/$(basename $1)
    fi
}

function check_version() {
    if [[ "" == $2 ]]; then
        return 0
    fi

    local version=$1 check=$2
    local winner=$(echo -e "$version\n$check" | sed '/^$/d' | sort -nr | head -1)
    [[ "$winner" = "$version" ]] && return 1
    return 0
}

function check_requirements() {

    ########################################
    # check docker version
    ########################################
    log_info "Checking docker version..."
    check_version $DOCKER_VERSION $DOCKER_MIN_VERSION

    if [ 0 == $? ]; then
        log_error "Minimum docker version required: $DOCKER_MIN_VERSION. Installed: $DOCKER_VERSION"
        exit 1
    else
        log_info "Docker version $DOCKER_VERSION accepted"
    fi
}

function clone_personal_environment_repository() {
    log_info "Checking personal environment repository: $REPOSITORY_ENVIRONMENT"
    git ls-remote $REPOSITORY_ENVIRONMENT > /dev/null 2>&1

    if [ 0 == $? ]; then
        mkdir -p tmp
        git clone $REPOSITORY_ENVIRONMENT $PATH_TMP_ENV
    else
        log_warning "Personal environment repository not found. You should create it :("
    fi
}

function add_to_file() {
    echo "" >> $1
    echo $2 >> $1
}

function check_domain_in_host() {
    log_info "Checking $DOMAIN in your machine..."

    ping -c1 $DOMAIN | grep $DOMAIN_IP > /dev/null 2>&1
    if [ 0 == $? ]; then
        log_info "$DOMAIN resolved to $DOMAIN_IP in your machine"
    else
        log_warning "You should configure '$DOMAIN_IP $DOMAIN' in /etc/hosts in your machine"
    fi
    echo
}

##################################################
# DOCKER FUNCTIONS
##################################################
function docker_image_build() {
    check_requirements
    clone_personal_environment_repository

    # copy files to temporary dir to copy to container
    echo
    log_info "Following files will be copied in container $CONTAINER..."
    for i in "${FILES_TO_DOCKER[@]}"; do
        copy_to_tmp "$i"
    done

    # add .bashrc alias
    echo
    log_info "Adding alias to $(basename $FILE_TMP_BASHRC)..."
    for i in "${BASHRC_ALIAS[@]}"; do
        add_to_file $FILE_TMP_BASHRC "$i"
    done

    # build docker image
    log_info "Building docker image $IMAGE..."
    docker build -t $IMAGE .
    echo

    # remove temporary dir
    rm -rf tmp
}

function docker_image_remove() {
    log_info "Removing docker image $IMAGE..."
    docker rmi -f $IMAGE
    echo
}

function docker_container_run() {
    log_info "Running docker container $CONTAINER..."
    docker run -dit \
        -p $PORT_HOST:$PORT_GUEST \
        -v $PATH_HOST_SOURCES:$PATH_GUEST_SOURCES \
        --add-host=$DOMAIN:127.0.0.1 \
        --name $CONTAINER $IMAGE

    echo
    check_domain_in_host
    log_info "Application is starting, it may take a while, please be patient :)"
    echo
}

function docker_container_bash_session() {
    log_info "Opening session in docker container $CONTAINER..."
    echo
    docker exec -t -i $CONTAINER bash
    echo
}

function docker_container_stop() {
    log_info "Stopping docker container $CONTAINER..."
    docker stop --time=1 $CONTAINER
    echo
}

function docker_container_remove() {
    log_info "Removing docker container $CONTAINER..."
    docker rm -f $CONTAINER
    echo
}

##################################################
# BANNER
##################################################
echo
log_banner " ================================= "
log_banner "           SaveTheCode             "
log_banner "       - docker launcher -         "
log_banner "                                   "
log_banner "       $CONTAINER        "
log_banner " ================================= "
echo

##################################################
# CHECK OPTION
##################################################
EXPECTED_ARGS=1
if [ $# -ne $EXPECTED_ARGS ]; then
	log_info "Script to launch '$CONTAINER' docker container from image '$IMAGE'"
	log_info "Usage: $(basename $0) <start | build | run | bash | stop | reset>"
	log_info "Example: $(basename $0) start"
	echo
	exit 1
fi

##################################################
# DOCKER OPTIONS
##################################################
case "$1" in
	build)
		docker_image_build
		;;
	start)
	    docker_image_build
	    docker_container_remove
		docker_container_run
		docker_container_bash_session
		;;
    run)
	    docker_container_remove
		docker_container_run
		;;
	bash)
		docker_container_bash_session
		;;
	stop)
		docker_container_stop
		;;
	reset)
	    docker_image_remove
	    ;;
    *)
        log_error "-- Invalid option --"
        ;;
esac
