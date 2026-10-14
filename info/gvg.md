---

# GVG — Guild vs Guild Module

## Status

**Поточний етап: Entities підготовлені, наступний крок — Repositories.**

Модуль GVG розробляється окремо в пакеті:

```text
com.wor_portal_app_backend.features.gvg
```

Використовується наявний backend stack:

```text
Spring Boot 4.1.1
Java 25
Spring Security
JWT
Spring Data JPA
PostgreSQL
Flyway
Lombok
```

Не змінювати наявні `Hero`, `UserHero`, `Guild` та `DemonSoldier` для реалізації GVG без окремої потреби.

---

## Package Structure

```text
com.wor_portal_app_backend.features.gvg
├── controller
├── dto
├── entity
├── enums
├── mapper
├── repository
└── service
```

Пакети використовують префікс `features.gvg`, а не `gvg` безпосередньо в кореневому package.

---

## GVG Enums

Створені три ENUM-файли.

### GvgMapType

```java
package com.wor_portal_app_backend.features.gvg.enums;

public enum GvgMapType {
    FORT,
    TOWER
}
```

### GvgTileType

```java
package com.wor_portal_app_backend.features.gvg.enums;

public enum GvgTileType {
    GROUND,
    PLATFORM
}
```

### AttackDirection

```java
package com.wor_portal_app_backend.features.gvg.enums;

public enum AttackDirection {
    UP,
    DOWN,
    LEFT,
    RIGHT
}
```

---

## GVG Database Schema

Погоджена SQL-схема містить шість типів/таблиць: три PostgreSQL ENUM-типа та п'ять таблиць GVG.

### PostgreSQL ENUM types

```text
gvg_map_type
    FORT
    TOWER

gvg_tile_type
    GROUND
    PLATFORM

attack_direction
    UP
    DOWN
    LEFT
    RIGHT
```

### Tables

```text
gvg_maps
gvg_map_tiles
gvg_presets
gvg_preset_heroes
gvg_preset_soldiers
```

Схема має бути створена через Flyway. Статус виконання міграції потрібно перевірити окремо.

---

## GvgMap

Table:

```text
gvg_maps
```

Fields:

```text
id
season_number
map_type
name
width
height
is_active
created_at
```

Rules:

- `map_type` використовує PostgreSQL ENUM `gvg_map_type`.
- `(season_number, map_type)` є унікальним.
- Для кожного `map_type` може бути не більше однієї активної карти.
- Одночасно можуть бути активні одна FORT і одна TOWER.
- `width` та `height` мають бути більшими за нуль.
- `season_number` має бути більшим за нуль.
- Карта не має `@OneToMany`-колекції tiles; tiles завантажуються окремим репозиторієм.

---

## GvgMapTile

Table:

```text
gvg_map_tiles
```

Fields:

```text
id
map_id
x
y
tile_type
attack_direction
created_at
```

Rules:

- Клітинка належить конкретній карті через `map_id`.
- `(map_id, x, y)` є унікальним.
- `x` та `y` починаються з нуля.
- `tile_type` використовує PostgreSQL ENUM `gvg_tile_type`.
- `attack_direction` використовує PostgreSQL ENUM `attack_direction` і може бути `NULL`.
- `created_at` заповнюється через `@PrePersist`.
- Для зв'язку з картою використовується `@ManyToOne(fetch = FetchType.LAZY)`.

---

## GvgPreset

Table:

```text
gvg_presets
```

Fields:

```text
id
guild_id
map_id
preset_code
name
description
created_at
updated_at
```

Rules:

- Пресет належить конкретній гільдії.
- Пресет прив'язаний до конкретної карти за `map_id`.
- Пресет не перемикається автоматично на нову активну карту після зміни сезону.
- `preset_code` унікальний тільки в межах гільдії: `(guild_id, preset_code)`.
- `name` — назва пресета.
- `description` — текстова нотатка про атаку.
- `created_at` встановлюється при створенні.
- `updated_at` оновлюється при зміні сутності через JPA.
- Зв'язки використовують наявний `Guild` і новий `GvgMap`.

---

## GvgPresetHero

Table:

```text
gvg_preset_heroes
```

Fields:

```text
id
preset_id
hero_id
tile_id
attack_direction
created_at
```

Rules:

- Герой посилається на наявну сутність `Hero`.
- Один герой може бути доданий до пресета лише один раз: `(preset_id, hero_id)`.
- `tile_id` nullable, щоб підтримувати незавершені пресети.
- `attack_direction` використовує PostgreSQL ENUM `attack_direction` і є обов'язковим.
- `created_at` заповнюється через `@PrePersist`.
- Не створювати дублікати сутності `Hero` або змінювати `UserHero` для GVG.

### Hero tile placement rules

```text
DEFENDER   → GROUND
FIGHTER    → GROUND
MARKSMAN   → PLATFORM
MAGE       → PLATFORM
HEALER     → PLATFORM
TACTICIAN  → GROUND або PLATFORM
```

Клас героя не зберігається окремо в GVG. Він береться з `Hero.className`.

Сервіс має перевіряти, що `tile` належить тій самій карті, що й пресет. Звичайного FK для цього недостатньо.

---

## GvgPresetSoldier

Table:

```text
gvg_preset_soldiers
```

Fields:

```text
id
preset_id
soldier_id
level
created_at
```

Rules:

- `soldier_id` посилається на наявну сутність `DemonSoldier`.
- Один солдат може бути доданий до пресета лише один раз: `(preset_id, soldier_id)`.
- `level` у GVG-пресеті має бути в діапазоні `1–10`.
- Рівень у пресеті не змінює `DemonSoldier.level`.
- `created_at` заповнюється через `@PrePersist`.
- Не створювати `UserDemonSoldier`.
- Таблиця не має `tile_id`: розташування солдатів не моделюється в поточній схемі.

---

## Hibernate PostgreSQL ENUM Mapping

Для полів, які відповідають власним PostgreSQL ENUM-типам, використовувати:

```java
@Enumerated(EnumType.STRING)
@JdbcTypeCode(SqlTypes.NAMED_ENUM)
```

Необхідні імпорти:

```java
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;
```

Застосовується до:

```text
GvgMap.mapType
GvgMapTile.tileType
GvgMapTile.attackDirection
GvgPresetHero.attackDirection
```

У `GvgPreset` та `GvgPresetSoldier` PostgreSQL ENUM-мапінг не потрібен.

Після змін необхідно перевірити компіляцію та інтеграцію з реальною PostgreSQL-схемою.

---

## GVG Entity Implementation Status

Підготовлені п'ять сутностей:

```text
✅ GvgMap
✅ GvgMapTile
✅ GvgPreset
✅ GvgPresetHero
✅ GvgPresetSoldier
```

Підготовлені три ENUM-и:

```text
✅ GvgMapType
✅ GvgTileType
✅ AttackDirection
```

Для сутностей додано або заплановано:

```text
✅ JPA mappings
✅ Table names
✅ Column names
✅ Foreign-key relationships
✅ Unique constraints
✅ PostgreSQL ENUM mappings
✅ Automatic created_at timestamps
✅ Preset updated_at lifecycle
```

Потрібно ще перевірити, що всі виправлення збережені у фактичних файлах та проєкт успішно компілюється.

---

## GVG Repositories — Next Step

Створити пакет:

```text
com.wor_portal_app_backend.features.gvg.repository
```

Додати:

```text
GvgMapRepository
GvgMapTileRepository
GvgPresetRepository
GvgPresetHeroRepository
GvgPresetSoldierRepository
```

Основні запити:

- Знайти карту за сезоном і типом.
- Знайти активну карту за типом.
- Отримати клітинки карти у порядку `y`, потім `x`.
- Отримати пресети поточної гільдії.
- Знайти пресет за `id` та `guildId`.
- Отримати героїв і солдатів конкретного пресета.

---

## GVG Services — Planned

```text
GvgMapService
GvgPresetService
GvgMapValidationService
GvgGuildContextService
```

### GvgGuildContextService

Визначає поточного користувача з SecurityContext/JWT і знаходить його гільдію.

**Frontend не передає `guildId` як довірене значення.**

Усі операції з пресетами повинні бути обмежені гільдією поточного користувача.

### GvgMapValidationService

Перевіряє:

- існування карти, клітинки, героя та солдата;
- належність клітинки карті пресета;
- сумісність класу героя з типом клітинки;
- напрямок атаки;
- рівень солдата `1–10`;
- дублікати героїв і солдатів.

### GvgPresetService

Плановані операції:

```text
Create preset
Get presets for current guild
Get preset by ID
Update preset
Delete preset
```

Для пошуку та зміни пресета обов'язково перевіряти належність поточній гільдії.

---

## GVG Controllers — Planned

```text
GvgMapController
GvgPresetController
GvgAdminMapController
```

Плановані endpoints:

```http
GET    /api/gvg/maps/{id}
GET    /api/gvg/maps/active/{mapType}

GET    /api/gvg/presets
GET    /api/gvg/presets/{id}
POST   /api/gvg/presets
PUT    /api/gvg/presets/{id}
DELETE /api/gvg/presets/{id}
```

Адміністративне керування картами й клітинками буде реалізоване окремо із перевіркою прав доступу.

---

## GVG Current Scope

У поточному scope:

```text
Map catalog
Map tiles
Season-bound presets
Hero placement
Hero attack direction
Optional preset soldiers
Preset soldier level
Guild-scoped access control
```

Поза поточним scope:

```text
UserDemonSoldier
Demon Soldier ownership
Automatic switching of preset maps
Storing hero placement class in GVG
Tile placement for preset soldiers
```

### Current next action

**Продовжити з п'яти GVG Repository-інтерфейсів**, використовуючи пакет `com.wor_portal_app_backend.features.gvg.repository` і вже створені сутності.
