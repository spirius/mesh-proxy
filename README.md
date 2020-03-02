# Simple SRV-based mesh proxy

The original use-case for this container was in combination with AWS ECS and AWS Cloud Map (a.k.a. Service Discovery).

ECS in `bridge` mode in combination with Cloud Map can register random container ports in route53 as SRV records.
Using AWS Mesh one can achive more flexible configuration, but Mesh requires `awsvpc` network mode and in that mode
each service in any case receives dedicated IP address and `A` records based service dicovery can be directly used
in client services without AWS Mesh as well.

## Usage

The setup utilized docker linking to proxy the traffic for target service via proxy container.

Example container defintion for terraform:

```HCL
{
  name      = "proxy"
  image     = "spirius/ecs-mesh-proxy:v0.0.1"
  essential = true
  memory    = 64
  environment = [
    {
      name = "PROXY_CONFIG"
      value = jsonencode([
        {
          port = 8080
          upstream = "myservice1.local"
        },
        {
          port = 8443
          upstream = "myservice2.local"
        }
      ])
    }
  ]
},
{
  name         = "myservice"
  ...

  links = ["proxy:myservice1.local", "proxy:myservice2.local"]
}
```

`myservice.local` and `myservice2.local` are cloud map services, providing service on container ports `8080` and `8443` respectively.
