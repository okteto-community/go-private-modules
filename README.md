# Getting Started on Okteto with Go

This example shows how to use the [Okteto CLI](https://github.com/okteto/okteto) to develop a Go Sample App directly in Kubernetes. The Go Sample App is deployed using Kubernetes manifests.

This is the application used for the [Getting Started on Okteto with Go](https://www.okteto.com/docs/samples/golang/) tutorial.



# Go Private Repository Modules


This sample addes the need of using as go module a private repository. 

In this case it is using "github.com/mnevadom/go-private/pkg/test" (which is private and needs to be imported inside the image when getting packages).


## Option 1: Secret with Repository SSH key

This option is using dockerfile: Dockerfile. 

Steps: 

- Create ssh public/private key
- Add to the private repository the public key 
    You can add it to the repository itself as Deploy Key or to your Github User. 
    It is more recommended to create a user with only the permissions you need and add it to that user
- Add the private key to the Okteto UI as Admin Variable with the name: `MY_SSH_KEY_ADMIN_VAR`
- Build your image with `okteto build hello-world`
- Change the Kubernetes k8s.yml to use the created image and `okteto deploy`

## Option 1: Secret with User Token

In this case we are going to use a token to be able to download the repository. 

Steps: 

- Create a token for your user in Github (recommended to user a specific user with specific access)
- Add the token to your Okteto UI with name: `GH_ACCESS_TOKEN`
- Build your image with `okteto build gh-token`
- Change the Kubernetes k8s.yml to use the created image and `okteto deploy`


### Warnings

It could happen that your base image is using another user with no access to ´mount´ the secret into the image. 

In that case, get the UID from the user and add it to the command: 

```
RUN --mount=type=secret,id=_env,dst=/.env,uid=10001
```