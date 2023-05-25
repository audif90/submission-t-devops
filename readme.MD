This is my writeup for the second task!

## Steps to run the app

- If you're running the app on your computer (not containerized), you can change the predefined .env to your liking.
- Start the container / run it on your computer with ```npm run start```.

> In the case of running the app on docker-compose, you can change the ```MONGO_HOST``` to the mongodb container name as long as its in the same ```docker network```. In the case of running it on Kubernetes, you can use environment block on the Kubernetes Manifest file to point it to the mongodb container/statefulsets.

### Add CRUD function

I use MongoDB for the CRUD function. The app is a simple contact-name App. using the hapi-mongodb library, I can implement it.

The app has an ENV config used for setting environment variables. This is used so that if the app is deployed to Docker / Docker-compose / Kubernetes. We can easily modify how the app connects to MongoDB

### Test the APIs

I've written a bash script called ```test.sh``` for the API testing with cURL. The method that I tried are

- GET
- POST
- PUT
- DELETE

### Steps to rollback

In the case of after deployment, we can rollback the deployment to v1 using this syntax
```bash
kubectl rollout undo deployment/hello-world-app --to-revision=<previous version>
```
we can easily know which version to undo using
```bash
kubectl rollout history deployment/hello-world-app
```
### Steps to scale the application

In the case of scaling the application to more or less instances. Kubernetes has a builtin function.

In the case of manually scalling the application, we can use the syntax below.
```bash
kubectl scale deployment/hello-world-app --replicas=<number of replicas>
```
With the syntax above, we can both scale up / down the amount of pods for the deployment.
In the case of automatically scale the application based on the limits given, we can use the syntax below.
```bash
kubectl autoscale deployment/hello-world-app --min=10 --max=15 --cpu-percent=80
```