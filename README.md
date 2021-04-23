# flutter_bolierplate_example

A new Flutter project.

## Getting Started

upgrade dependencies

```sh
$ flutter pub outdated --no-dev-dependencies --up-to-date --no-dependency-overrides
$ flutter pub upgrade --major-versions
```

generate models

```sh
$ flutter packages pub run build_runner build --delete-conflicting-outputs

$ flutter pub run build_runner serve --delete-conflicting-outputs
```