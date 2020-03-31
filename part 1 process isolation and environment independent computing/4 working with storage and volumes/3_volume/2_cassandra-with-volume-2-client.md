# manual steps

```shell
sleep 10s
docker logs -f cass1 # wait the cassandra server started

# run a Cassandra client tool (CQLSH) and connect to your running server
# run docker and execute cqlsh command inside to connect cassandra server (cass)
# --rm: was automatically removed when the command stopped
docker run -it --rm \
  --link cass1:cass \
  cassandra:2.2 cqlsh cass
```

```sql
select *
  from system.schema_keyspaces
  where keyspace_name = 'docker_hello_world';

create keyspace docker_hello_world
with replication = {
    'class' : 'SimpleStrategy',
    'replication_factor': 1
};

select *
  from system.schema_keyspaces
  where keyspace_name = 'docker_hello_world';

quit
```

```shell
docker stop cass1
docker rm -vf cass1
```
