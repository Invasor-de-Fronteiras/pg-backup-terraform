# Changelog

## [Unreleased]

### Fixed

- `providers.tf`: Fixed SSM parameter parsing to correctly handle values containing `=` characters (e.g. base64 strings)

### Added

- `variables.tf`: Added `description` to all variables
- `variables.tf`: Added `schedule` variable to configure the backup cron expression (default: `@daily`)
- `variables.tf`: Added `additional_environments` variable to inject extra env vars into the Kubernetes secret
- `kubernetes.tf`: Wired `additional_environments` into the Kubernetes secret via `merge()`

### Changed

- `kubernetes.tf`: Increased `failed_jobs_history_limit` from `1` to `3` for better debugging
- `kubernetes.tf`: Increased `starting_deadline_seconds` from `10` to `300` to avoid jobs being skipped on minor scheduler delays
- `kubernetes.tf`: Increased `ttl_seconds_after_finished` from `10` to `600` to allow log inspection after job completion
