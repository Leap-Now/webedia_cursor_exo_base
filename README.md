# LA FEMME DE MENAGE

This is an Eleventy (11ty) static site project for the movie "La femme de ménage".

## Setup

### Prerequisites

- Docker & Docker Compose (for containerized development)

### Package Authentication

This project uses the private `@webediagroup/static-showtime` package from GitLab NPM registry.
Authentication is configured via `.npmrc` using the `NPM_TOKEN` environment variable.

> **ℹ️ To obtain an NPM token for installing private packages:**
>
> 1. Visit [GCP Secret Manager: tf-gitlab-sa-ospe-token](https://console.cloud.google.com/security/secret-manager/secret/tf-gitlab-sa-ospe-token/versions?project=prj-shd-prd-secrets-1baf)
> 2. Copy the latest secret value.
> 3. Paste it in a `.env` file at the project root as:
>    ```
>    NPM_TOKEN=YOUR_TOKEN
>    ```
> 4. Run:
>    ```bash
>    make up
>    ```
>
> The `.env` is used to inject `NPM_TOKEN` for private package registry authentication.

### Local Development

```bash
# Start development server with hot-reload
make up

# Site available at http://localhost:8080
```

## Documentation

- **Quick start**: See `@/docs/getting-started.md`
- **Full documentation**: `@/docs/` - Architecture, coding standards, deployment, troubleshooting
- **Project specifications**: `@/.specs/` - Detailed specs and requirements
- **Implementation status**: `@/.specs/status.md`
- **Known issues**: `@/.specs/bugs/`
- **Code review**: `BUGBOT.md` - Systematic code review guide
- **Retrospective**: `retrospective.md` - Post-feature improvement process
