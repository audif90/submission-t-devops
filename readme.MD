
This is my writeup for the first task!

### Create a simple Hello World HTTP application using any programming language and framework of your choice

For this part, I'm using the following :
- **NodeJS**

 	Personally i've been into NodeJS ever since I started web programming, I've tried PHP before but NodeJS's syntax is just better suited for me. I've also used NodeJS for any work-related internal applications.
- **Hapi**

  The reason I use Hapi is because it's the framework I'm used to, I learned web programming from a colleague who recommends Hapi over Express. I've also used Express but since I'm more used to Hapi, I'm using it.

For the prerequisite of the app is running in **port 8080** is configured by the server init 
```JavaScript
const server = Hapi.server({
        port: 8080,
        host: '0.0.0.0'
    })
``` 
### Packaging as Docker Container

Simple enough, create a ```Dockerfile``` for the app. I use ``` node:lts-slim``` as it's a both slim and LTS version, making it would last long support and also small in size.

### Deploy the app to an orchestrator
The requirements requires me to :
- **Run the app using port 80**

    This is achieveable by exposing the service to a ```NodePort```, then ```port-forward``` the port to Localhost.
- **Limit its usage that it will consume 0.1 CPU + 128M memory by default and 1 CPU + 512M memory at max.**

    In the Deployment manifest, we can easily adjust the bottom and upper limit of the pods. I configured it by putting the following
    ```yaml
    resources:
          requests:
            cpu: "100m"
            memory: "128M"
          limits:
            cpu: "1000m"
            memory: "512M"
    ```

### Load testing the application
I'm using a Docker Container for doing the load testing, the reason is so that I can easily spawn a Docker Container using a Docker Image from Dockerhub 

### Create automation script to set up the solution from stracth

I've made a bash script that does the following:

- **Build docker image**
- **Apply the Kubernetes manifests**
- **Run Load testing from Docker Container**

The script should be executed in the same folder, under any user in the Docker group as its uses Docker