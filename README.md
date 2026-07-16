# ancestor

[English version](README.en.md)

> **Музейный экспонат (2020)** — личная лаборатория по сборке кастомных образов workspace для [Eclipse Che](https://www.eclipse.org/che/) на [OpenShift Online Starter](https://www.openshift.com/) через [Source-to-Image (S2I)](https://github.com/openshift/source-to-image).
>
> Одна строка для резюме: *Образ Che-workspace на S2I с Miniconda; удалось упаковать Python и Node.js в один образ (ограниченный успех — языковой tooling IDE так и не довёл).*

Репозиторий хранится как **кураторский исторический артефакт**, а не как рабочая современная инфраструктура. OpenShift Online Starter и то поколение Che уже в прошлом; ценность здесь — в эксперименте и в том, чему он научил.

---

## Что это было

Около мая 2020 мне нужен был Che-workspace сильнее стокового редактора-контейнера: место, где toolchain принадлежит мне. Модель OpenShift гнала сборки через S2I (по сути Dockerfile от имени non-root). База — Che-образ на RHEL, который обычный пользователь с нуля почти не пересоберёт:

- База: [`quay.io/eclipse/che-cpp-rhel7`](https://quay.io/eclipse/che-cpp-rhel7)  
  (сама на образе Red Hat LLVM toolset)
- Результат: [`docker.io/isbur/ancestor`](https://hub.docker.com/repository/docker/isbur/ancestor)

Идея: взять этот Che-ancestor, через S2I `assemble` поставить **Miniconda**, описать conda-окружение, запушить в Docker Hub и снова открыть из Che `devfile`.

## Итог

| Результат | Комментарий |
|-----------|-------------|
| **Удалось (ограниченно)** | В одном образе оказались **и Python, и Node.js** (через conda; ветки `oconda` / `npm`). Продолжение жило в других репозиториях. |
| **Не доделано** | Языковой **tooling** Che/Theia (расширения Python / sidecar-контейнеры плагинов) так и не подключил. Рантаймы в образе были; «ум» IDE — нет. |
| **Платформа умерла** | OpenShift Online Starter и тот стек Che — история. Этот экспонат не рассчитан на реанимацию as-is. |

## Карта для посетителя

```text
  Базовый образ Che (RHEL / che-cpp-rhel7)
            │
            ▼
  S2I assemble  (.s2i/bin/assemble)
    · активация / настройка Miniconda
    · conda env "ancestor" (python, позже + nodejs, …)
            │
            ▼
  S2I run       (.s2i/bin/run)
    · активация env, контейнер остаётся живым
            │
            ▼
  OpenShift BuildConfig  →  push в Docker Hub
            │
            ▼
  Che workspace через devfile.yaml  (image: isbur/ancestor:…)
```

**Основные экспонаты (эта ветка):**

| Путь | Роль |
|------|------|
| [`.s2i/bin/assemble`](.s2i/bin/assemble) / [`run`](.s2i/bin/run) | Сборка и вход в образ (S2I) |
| [`buildConfig/`](buildConfig/) | Генератор OpenShift `BuildConfig` на Jinja2 |
| [`makefile`](makefile) | Личная автоматизация (`galushka`, settings, login) |
| [`devfile.yaml`](devfile.yaml) | Che workspace на собранном образе |
| [`archive/`](archive/) | Недоделки и bash-history (не часть истории успеха) |

**Смежные ветки (линия dual-runtime):**

- `oconda` / `npm` — conda env с `python` **и** `nodejs` (плюс эксперименты npm/oclif)
- `zz_python`, `conda_fresh`, `zz_gentoo-prefix`, `zz_logs` — боковые опыты

Имена вроде `galushka`, `mothercare`, `mommy` — вкус эпохи, оставлены как есть.

## Чему я здесь учился

- Сборке образов non-root в жёстких рамках платформы (S2I на OpenShift)
- Превращению базового образа cloud IDE в свой слой toolchain (conda)
- Циклу BuildConfig → registry → workspace
- Растягиванию одного workspace-образа на несколько рантаймов — и границе, где кончается **содержимое образа** и начинаются **sidecar’ы IDE-tooling**

## Исторические оговорки (намеренно)

- **Не считать продакшеном.** Секреты и токены в шаблонах/env — привычки лаборатории 2020 (например, login-токен в build env). Для реальных систем так нельзя; оставлено как урок, не как рецепт.
- `assemble` на *этой* ветке тоньше, чем линия `oconda`/`npm`, где появился Node.
- Незавершённые идеи фабрики (`mommy`, `pot-init`, …) лежат в [`archive/`](archive/).

## Зависимости (той эпохи)

git · conda · python · pypandoc · python-docx · openshift-cli · jinja2 · (Py)YAML

---

*Только экспонат. Не поддерживается под актуальный OpenShift, Dev Spaces или Kubernetes.*
