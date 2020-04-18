
# Error creating when exists

The docker config command supports only create and rm operations to manage the cluster’s config resources. If you try to create a config resource multi- ple times by using the same name, Docker will return an error saying the resource already exists:

```shell script
$ docker config create greetings_dev_env_specific_config \
    api/config/config.dev.yml
```

Error response from daemon: rpc error: code = AlreadyExists
desc = config greetings_dev_env_specific_config already exists

# Error updating when exists

Similarly, if you change the source configuration file and try to redeploy the stack by using the same config resource name, Docker will also respond with an error:

```shell script
$ DEPLOY_ENV=dev docker stack deploy \
    --compose-file docker-compose.yml greetings_dev
```

failed to update config greetings_dev_env_specific_config:
Separating application and configuration 253 Error response from daemon: rpc error: code = InvalidArgument
    desc = only updates to Labels are allowed

# Update configurations

The answer is that you don’t update Docker config resources. Instead, when a configuration file changes, the deployment process should create a new resource with a different name and then reference that name in service deployments.

The common convention is to append a version number to the configuration resource’s name. The greetings application’s deployment definition could define an `env_specific_config_v1` resource. When the configuration changes, that configuration could be stored in a new config resource named `env_specific_config_v2`. Services can adopt this new config by updating configuration references to this new config resource name.
