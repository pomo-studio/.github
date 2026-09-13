# 0001. Edge blue/green with CloudFront Functions and KeyValueStore

## Status

Accepted.

## Context

The Internet Ingress blueprint puts one CloudFront distribution in front of two
deployments, blue and green, each a private VPC origin. It has to pick a
deployment per request, so that promoting a colour, or shifting a percentage, is
a configuration change rather than a `terraform apply`. Requirements: one
hostname, no redirect, an arbitrary weight, per-viewer pinning, and the two
deployments must never serve each other's cached responses.

Options considered:

1. **Lambda@Edge origin switching.** Rejected. The VPC origins documentation
   lists "Origin request and origin response triggers with Lambda@Edge" under
   protocol and feature restrictions, so a Lambda@Edge function cannot select a
   VPC origin. The origin-request `origin` object only accepts custom or S3
   origins.
2. **CloudFront continuous deployment.** Valid, and it supports VPC origins with
   weight-based routing and session stickiness. But it routes viewers to a
   staging distribution and caps the weight, and its unit of change is a whole
   distribution configuration, not a per-request origin choice.
3. **CloudFront Functions with origin modification.** Supported. JavaScript
   runtime 2.0 added `cf.selectRequestOriginById()`, which selects an origin
   already defined in the distribution, and the documentation states it can
   select a VPC origin. `cf.updateRequestOrigin()` exists too but cannot target
   VPC origins, so it is not used.

## Decision

Use a viewer-request CloudFront Function with the JavaScript runtime 2.0.

- **Origin selection.** `cf.selectRequestOriginById(deployment)` switches the
  request to the chosen deployment's VPC origin, by origin ID. The distribution
  defines one origin per deployment.
- **Configuration at the edge.** The function reads rollout state from CloudFront
  KeyValueStore. CloudFront Functions have no network access, so Parameter Store
  cannot be read directly: a sync Lambda projects the parameter into the store.
  Parameter Store stays the source of truth.
- **Weight and pinning.** The function honours a pin cookie when present,
  otherwise selects by weight. A viewer-response function sets the pin cookie
  from a marker the viewer-request function added.
- **Cache correctness.** Selecting an origin does not change the cache key, so
  the viewer-request function stamps a deployment header on every request and the
  cache policy keys on that header. Without it, blue and green can serve each
  other cached objects.

Consequences for the components:

- `cloudfront-frontdoor` defines one origin per deployment, one default
  behaviour, a cache policy keyed on the deployment header, and CloudFront
  Function associations.
- `cloudfront-edge-router` is a Parameter Store parameter, a KeyValueStore, a
  sync Lambda, and a published CloudFront Function. Its outputs are the function
  ARN and the header name, which the distribution associates and keys on.
- The blueprint wires the router's function ARN into the distribution's
  associations and passes the deployment header.

## References

- CloudFront Functions origin modification helpers, including
  `selectRequestOriginById` and the VPC origin support note.
- Restrict access with VPC origins, protocol and feature restrictions.
- Building Multi-Region Active-Active Architectures with CloudFront VPC origins
  and Advanced Routing, AWS Networking and Content Delivery blog, August 2026,
  which implements weighted, geo, and session-affinity routing at the edge over
  VPC origins with KeyValueStore.
