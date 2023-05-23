
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

Simple enough, create a ```Dockerfile``` for the app. I use ```node:lts-slim``` as it's a both slim and LTS version, making it would last long support and also small in size.

### Deploy the app to an orchestrator

The requirements requires me to :

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

### Exposing the App
In order to expose the app on ```localhost:80```, I'm using nginx. This is achieveable by exposing the service to a ```NodePort```, then use dockerized nginx to map the nodePort to localhost port 80. Since the host device has separate IP with the container itself, we could do a simple ```sed -i``` to replace the placeholder IP in the conf file with an output from ```hostname -I``` to map the proxy_pass block to the right place. 

First, I prepared a simple configuration template for ```proxy_pass```, with the destination's IP Address written as ```placeholder-host-ip```. Then I ran a ```sed -i "s/placeholder-host-ip/ **Host's IP Variable**/g" default.conf``` to replace the existing placeholder file with a new one with the host's IP. Then I ran the Docker Container with the syntax below
```bash
docker run -d --name nginx-reverse-proxy -p 80:80 -v $(pwd)/conf/default.conf:/etc/nginx/conf.d/default.conf:ro nginx:latest
```
I also reran the ```sed``` command to ensure the placeholder file is still usable on the next iteration of the script.

> :warning: there are other method such as using Ingress or port-forwarding the nodePort to localhost port 80 using ```sudo``` privileges. **This is unsafe!**. Thus the easiest and secure way to achieve this is using an external reverse proxy solution. Which is nginx in this case. 

### Load testing the application
I'm using a Docker Container for doing the load testing, the reason is so that I can easily spawn a Docker Container using a Docker Image from Dockerhub 

### Create automation script to set up the solution from stracth

I've made a bash script that does the following:

- **Check for root privileges**
- **Build docker image**
- **Apply the Kubernetes manifests**
- **Creating the reverse proxy for pointing service port to port 80**
- **Run Load testing from Docker Container**

The script should be executed in the same folder, under any user who's in the Docker group.
