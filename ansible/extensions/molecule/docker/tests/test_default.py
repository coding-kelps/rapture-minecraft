import subprocess

PACKAGE = "docker.io"
PACKAGE_GROUP = "docker"
PACKAGE_SERVICE = "docker.service"

def test_docker_group_exists(host):
    """
    Tests if docker group exists.
    """
    assert host.group(PACKAGE_GROUP)

def test_docker_service_running(host):
    """
    Tests if docker.service is running.
    """
    assert host.service(PACKAGE_SERVICE).is_running

def test_docker_service_enabled(host):
    """
    Tests if docker.service is enabled.
    """
    assert host.service(PACKAGE_SERVICE).is_enabled

def test_docker_pull_custom_registry(host):
    """
    Tests if docker can pull a custom image from a private registry.
    """
    custom_image = "europe-west9-docker.pkg.dev/kelps-433221/kelps/nginx:latest"

    cmd = host.run(f'docker pull {custom_image}')
    
    assert cmd.succeeded
