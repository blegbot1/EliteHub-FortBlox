# ELITE HUB — Fort Blox

Клиентский скрипт для [Fort Blox](https://www.roblox.com/games/8884043854) (place `8884043854`).
Тёмно-фиолетовая тема **ELITE HUB**: ESP, клиентский (silent) аим, чамсы, радар, авто-хил, авто-сундуки, TP игроков.

Интерфейс — [Rayfield](https://github.com/SiriusSoftwareLtd/Rayfield) с собственной темой `FB_Theme` (чёрный + фиолетовый градиент в топбаре).

---

## Возможности

### ESP
| Пункт | Описание |
|---|---|
| ESP ON/OFF | Общий переключатель |
| Lines (tracers) | Линии от земли/стены до игрока |
| Chams (highlight) | Подсветка персонажа через `Highlight` |
| Blue friends | Друзья всегда синие, аим их не трогает |
| Rainbow ESP | Радуга для всех элементов ESP |
| Enemy gun ESP | Название оружия врага в нике |
| Chest ESP (unopened) | Подсветка неоткрытых сундуков |
| Names + distance | Ник, дистанция, пушка |
| 3D Box | Объёмный бокс (12 рёбер) |
| Off-screen arrows | Стрелки за краем экрана |
| Radar | Радар снизу справа + sweep |
| Пульсы | Box / tracer / chams — анимация масштаба и толщины |

### Aim (client / silent)
- **Client Aim (silent)** — камера не двигается, выстрел подменяется в хуке `__namecall`
- Оригинальный выстрел заменяется на выстрел в голову (`Hit` → `Shoot`), **без двойного выстрела**
- **Aim FOV (pixels)** — поиск цели от центра экрана
- Дистанция цели = **дальность пушки в руках** (`Config:GetConfig(gun).Range`)
- **Hit part** — Head / UpperTorso / HumanoidRootPart
- **Sticky target** — держит цель, пока она жива
- **Triggerbot** + задержка
- **Wall check** — выключен = стреляет сквозь стены
- **Skip squadmates** — сквадмейтов не бьём (сервер всё равно не даёт урон)
- Статус в реальном времени: `HOOK: on/off | TARGET: ник м / searching... / ERR: ...`

### Friends
- Список всех игроков сервера, add/remove по нику
- Аим **никогда** не целится в друзей, в ESP они синие

### Misc
- **Speed lock** — Walk / Sprint (Shift) отдельно
- **Instant chests** (холд = 0) и **Auto open near chest** (только в радиусе 16 м, как требует сервер)
- **Auto HP / Auto Shield** — берёт хилку в руки, `Init` → `Use`, держит огонь время применения, возвращает пушку
- **TP all players to me** — все игроки телепортируются на одну точку позади и следуют за тобой (кучка), новые спавнятся сразу туда же
- **Ping/FPS panel** с счётчиком фрагов `K:`

---

## Установка

1. Открой **Executor** (используется проверенный: Real 2.7.0)
2. Вставь содержимое `EliteHub.lua` и запусти
3. Скрипт сам подгружает Rayfield через `HttpGet` — интернет нужен при первом запуске

## Управление

| Клавиша | Действие |
|---|---|
| ЛКМ | Выстрел (с аимом — в голову) |
| `Shift` | Спринт (при Speed lock) |
| ПКМ по окну | Перетащить окно |

---

## Структура

```
EliteHub-FortBlox/
├── EliteHub.lua   # весь скрипт (одним файлом, ~2500 строк)
├── README.md
└── .gitignore
```

## Настройки

Все флаги живут в `getgenv().FB_*` и переопределяются до/после запуска:

```lua
getgenv().FB_Aim = true
getgenv().FB_AimFOV = 200
getgenv().FB_HitPart = "UpperTorso"
getgenv().FB_Theme.Background = Color3.fromRGB(12, 10, 18)
```

## Заметки

- Синтаксис проверен `luac -p`
- Raycast использует только `FilterDescendantsInstances` (новый API без `Blacklist`)
- Промпт сундука ищется вручную через `GetDescendants` (`Chest > Key > ProximityPrompt`) — `FindFirstChildOfClass(_, true)` в этом игре не работает

## Ответственность

Скрипт меняет только клиентское поведение и отправляет штатные ремоуты игры. Он не обходит античит, не инжектит процесс и не трогает чужие аккаунты. Использование — на свой страх и риск, правила игры лучше прочитать.