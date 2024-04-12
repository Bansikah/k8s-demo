resource "docker_image" "centos_python_container" {
  name = "centos_python_container"
  build {
    context = "."
    dockerfile = "Dockerfile"
  }
}

resource "docker_image" "centos_python_container" {
  name  = "centos_python_container"
}
