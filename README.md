# kong-dojo

A repo to deploy Kong locally to learn about it and its interactions with related deployment infrastructure.



## Getting Started

After following the installation instructions in either one of the sub-directories [docker-compose](./docker-compose) or [k3d](./k3d), it's time to configure your services to route through your proxy and install a policy to demonstrate how that works.

Run the following commands from within the `kong-dojo/shared` directory. Technically they can be run elsewhere, but we're simplifying the instructions to ease you into things.

#### Using decK (applies to all Kong environments)

1. `./apply-proxy.sh ./kong.yaml`

   This runs a container of decK (declarative configuration for Kong) and loads the script's argument as the input file, into which we have pre-populated a proxy of the httpbin.org/anything service and applied correlation-id and rate-limiting plugins to.

#### Using kubectl (applies only when Kong runs within Kubernetes)

1. `kubectl apply -f ../k3d/manifests/httpbin.yaml -n kong-ent` (this deploys a container of httpbin, configuring kong annotations to use the `/anything` path within that service and some plugin annotations that won't take effect until we add their `KongPlugin` definitions later)

   Note that with just step 1, we have done nothing yet to expose that service to the cluster's Ingress Controller. If you load `http://localhost:8000/httpbin` now, you will receive a 404.

2. However, by running: `kubectl apply -f ../k3d/manifests/httpbin-ingress.yaml -n kong-ent` , we apply an ingress rule, so now when you load `http://localhost:8000/httpbin` you will receive a response, specifically, the same (well, nearly so) as loading `http://httpbin.org/anything`)

We are now ready to apply plugins to modify the behavior of the service being proxied. This is where the real value of applying Kong's Proxy (which in this case is configured through the Kong Ingress Controller) starts to show up.

3. To apply the [Correlation ID Plugin](https://docs.konghq.com/hub/kong-inc/correlation-id/) run: `kubectl apply -f ../k3d/manifests/correlation-plugin.yaml -n kong-ent` . Loading `http://localhost:8000/httpbin` will now have an added `Kong-Request-ID` headed added to its request and because we enabled `echo_downstream: true` we see the header in the response as well.
4. The exercise of applying a [Rate-Limiting](https://docs.konghq.com/hub/kong-inc/rate-limiting/) or [Rate-Limiting-Advanced](https://docs.konghq.com/hub/kong-inc/rate-limiting-advanced/) plugin is left to you. Its annotation is already in the ingress manifest.

## Testing the Proxy

1. Check your proxy by loading http://localhost:8000/httpbin
2. Depending on which plugin(s) have been applied:
   1. Note the presence of `Kong-Request-ID` and/or
   2. Note the rate-limit and presence of a `X-RateLimit-Limit-Minute` header

## Cleanup

See the corresponding cleanup steps in the sub-directories.

## Exploring futher

While we have deployed plugins confgured at the Kong `Service` level here, please note that you can also deploy them at the Kong `Route` (which translates to the Kubernetes Ingress rule level) or at the Global (Kubernetes Cluster) level. Those exercises are left to you as you are ready to learn more.

After that, I recommend you try configuring different plugins as well. You can find some helpful syntax in the [Kong Plugin Hub](https://docs.konghq.com/hub/) and [here](https://gist.github.com/nedward/dd445bfa2be781fd9ce32f3122b55895).