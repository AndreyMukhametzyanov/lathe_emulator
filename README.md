# Lathe Emulator 

## Описание
Данная программа позволяет имитировать работу станка в (данном случае фрезерного, а при желании любого).
Необходима для использования в проекте [Machine monitoring system](https://github.com/AndreyMukhametzyanov/mms).
Разработана на языке Crystal с применением небольшой щепотки магии.

## Функционал
Есть, значит, три путЯ:
- /api/info - получение краткой информации о станке
- /api/full_metrics - получение полной информации о станке
- /api/change_state - изменение статуса станка (вкл/выкл). Необходимо для удаленного управления станком через [Machine monitoring system](https://github.com/AndreyMukhametzyanov/mms).

При включенном станке ключевые данные меняются рандомно имитируя его работу.

## Установка

```bash
shards install
```

## Использование

```bash
crystal run app.cr
```

## Тесты

```bash
KEMAL_ENV=test crystal spec
```

## Разработчик

- [Andrey](https://github.com/AndreyMukhametzyanov) - creator and maintainer and [великодушный пожизненный диктатор](https://ru.wikipedia.org/wiki/Великодушный_пожизненный_диктатор)
