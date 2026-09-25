# Kubernetes course
This repository contains the course files for my Kubernetes course on Udemy: https://www.udemy.com/learn-devops-the-complete-kubernetes-course/?couponCode=KUBERNETES_GITHUB

## Example database secrets

The secret example files intentionally contain no credential data. Before deploying `deployment/helloworld-secrets-volumes.yml` or `service-discovery/helloworld-db.yml`, provide these values through a restricted local environment or secret manager and run `scripts/create-example-secrets.sh`:

- `DB_USERNAME` and `DB_PASSWORD` create `db-secrets`.
- `HELLOWORLD_USERNAME`, `HELLOWORLD_PASSWORD`, `HELLOWORLD_ROOT_PASSWORD`, and `HELLOWORLD_DATABASE` create `helloworld-secrets`.

Do not commit secret values or generated secret manifests. The script uses temporary files with owner-only permissions and removes them when it exits.
