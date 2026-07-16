# ancestor

[Русская версия](README.ru.md)

> **Museum exhibit (2020)** — a personal lab for building custom [Eclipse Che](https://www.eclipse.org/che/) workspace images on [OpenShift Online Starter](https://www.openshift.com/) via [Source-to-Image (S2I)](https://github.com/openshift/source-to-image).
>
> Resume one-liner: *S2I-based Che workspace image with Miniconda; successfully packed Python and Node.js into one image (limited success — IDE language tooling was left unfinished).*

This repository is kept as a **curated historical artifact**, not as runnable modern infrastructure. OpenShift Online Starter and that Che generation are gone; the value here is the experiment and what it taught.

---

## What this was

Around May 2020 I needed a Che workspace that was more than a stock editor container: a place where I could own the toolchain. OpenShift’s model pushed builds through S2I (essentially a Dockerfile run as a non-root user). The base was a RHEL-flavored Che image that ordinary users couldn’t easily rebuild from scratch:

- Base: [`quay.io/eclipse/che-cpp-rhel7`](https://quay.io/eclipse/che-cpp-rhel7)  
  (itself on Red Hat’s LLVM toolset image)
- Output: [`docker.io/isbur/ancestor`](https://hub.docker.com/repository/docker/isbur/ancestor)

The idea: start from that Che ancestor, run S2I `assemble` to install **Miniconda**, declare a conda env, push the result to Docker Hub, then open it again from a Che `devfile`.

## Outcome

| Result | Notes |
|--------|--------|
| **Succeeded (limited)** | One image carried **both Python and Node.js** (via conda; see branches `oconda` / `npm`). Related follow-on work lived in other repos. |
| **Not finished** | Che/Theia **language tooling** (Python extensions / sidecar plugin containers) was never wired up. Runtimes were in the image; IDE intelligence was not. |
| **Platform died** | OpenShift Online Starter and that Che stack are historical. This exhibit is not meant to be revived as-is. |

## Visitor map

```text
  Che base image (RHEL / che-cpp-rhel7)
            │
            ▼
  S2I assemble  (.s2i/bin/assemble)
    · activate / configure Miniconda
    · conda env "ancestor" (python, later + nodejs, …)
            │
            ▼
  S2I run       (.s2i/bin/run)
    · activate env, keep container alive
            │
            ▼
  OpenShift BuildConfig  →  push to Docker Hub
            │
            ▼
  Che workspace via devfile.yaml  (image: isbur/ancestor:…)
```

**Main exhibits (this branch):**

| Path | Role |
|------|------|
| [`.s2i/bin/assemble`](.s2i/bin/assemble) / [`run`](.s2i/bin/run) | Image build & entry (S2I) |
| [`buildConfig/`](buildConfig/) | Jinja2 generator for OpenShift `BuildConfig` |
| [`makefile`](makefile) | Personal automation (`galushka`, settings, login helpers) |
| [`devfile.yaml`](devfile.yaml) | Che workspace pointing at the built image |
| [`archive/`](archive/) | Unfinished drafts & bash-history scratch (not part of the “success” story) |

**Related branches (lineage of the dual-runtime win):**

- `oconda` / `npm` — conda env with `python` **and** `nodejs` (and npm/oclif experiments)
- `zz_python`, `conda_fresh`, `zz_gentoo-prefix`, `zz_logs` — side experiments

Naming like `galushka`, `mothercare`, `mommy` is intentional period flavor, left as-is.

## What I was practicing

- Non-root, platform-constrained image builds (S2I on OpenShift)
- Turning a cloud IDE base image into a personal toolchain layer (conda)
- BuildConfig → registry → workspace loop
- Stretching one workspace image toward multiple runtimes — and learning where **image contents** stop and **IDE tooling sidecars** begin

## Historical caveats (on purpose)

- **Do not treat as production.** Secrets and tokens in templates/env wiring reflect 2020 lab habits (e.g. login token passed into build env). Wrong for anything real; left visible as a lesson, not a recipe.
- `assemble` on *this* branch is a thinner snapshot than the `oconda`/`npm` line where Node landed.
- Incomplete factory ideas (`mommy`, `pot-init`, …) live under [`archive/`](archive/).

## Dependencies (of the era)

git · conda · python · pypandoc · python-docx · openshift-cli · jinja2 · (Py)YAML

---

*Exhibit only. Not maintained for current OpenShift, Dev Spaces, or Kubernetes.*
