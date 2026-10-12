Так. Ось **повний актуальний контекст WoR Portal**, уже з урахуванням того, що **модуль Demon Soldiers повністю реалізований тобою: код + Flyway migration + фінальний `demons.json`**.

Можеш зберегти цей блок як актуальний context для наступної роботи.

---

# WoR Portal — Current Project Context

## Stack

### Frontend
- React
- Vite
- Tailwind
- Axios

### Backend
- Spring Boot
- Spring Security
- JWT
- JPA
- PostgreSQL
- Flyway

---

# URLs

### Frontend

```text
http://localhost:5173
```

### Backend

```text
http://localhost:8080
```

### API prefix

```text
/api
```

---

# Axios

`baseURL`:

```text
http://localhost:8080/api
```

JWT:

```js
localStorage["token"]
```

Header:

```text
Authorization: Bearer <token>
```

Frontend **не додає `/api` вручну**.

Правильно:

```js
api.get('/heroes')
api.get('/user-heroes/${userId}')
api.get('/demon-soldiers')
```

Неправильно:

```js
api.get('/api/heroes')
api.get('/api/demon-soldiers')
```

---

# Auth

```http
POST /auth/login
POST /auth/register
```

---

# Users

```http
GET /users/me
```

---

# Heroes

```http
GET /heroes
GET /heroes/class/{className}
```

Backend:

```http
GET /api/heroes
GET /api/heroes/class/{className}
```

---

# User Heroes

```http
GET /user-heroes/{userId}

POST /user-heroes/{userId}/hero/{heroId}

DELETE /user-heroes/{userId}/hero/{heroId}
```

Backend:

```http
GET /api/user-heroes/{userId}

POST /api/user-heroes/{userId}/hero/{heroId}

DELETE /api/user-heroes/{userId}/hero/{heroId}
```

---

# Guild

```http
POST /guilds/create
POST /guilds/join
```

---

# Roles

```text
ADMIN
LEADER
OFFICER
MEMBER
```

---

# Hero Entity

```java
@Entity
@Table(name = "heroes")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Hero {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 50)
    private String name;

    @Column(name = "image_slug", nullable = false)
    private String imageSlug;

    @Column(name = "class_name", nullable = false)
    private String className;

    @Column(name = "class_icon_slug")
    private String classIconSlug;

    @Column(name = "rarity")
    private String rarity;

    @ElementCollection
    @CollectionTable(
            name = "hero_faction_list",
            joinColumns = @JoinColumn(name = "hero_id")
    )
    @Column(name = "faction_name")
    private List<String> factions;

    @Column(name = "lord_faction")
    private String lordFaction;

    @ElementCollection
    @CollectionTable(
            name = "hero_tags",
            joinColumns = @JoinColumn(name = "hero_id")
    )
    @Column(name = "tag")
    private List<String> tags;
}
```

---

# UserHero Entity

```java
@Entity
@Table(
        name = "user_heroes",
        uniqueConstraints = {
                @UniqueConstraint(
                        columnNames = {"user_id", "hero_id"}
                )
        }
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserHero {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hero_id", nullable = false)
    private Hero hero;

    @Column(name = "awakening_level", nullable = false)
    private int awakeningLevel = 0;
}
```

---

# DTOs

## HeroResponseDto

```java
@Data
@Builder
public class HeroResponseDto {

    private Long id;
    private String name;
    private String imageSlug;
    private String className;
    private String classIconSlug;
    private String rarity;
    private List<String> factions;
    private String lordFaction;
    private List<String> tags;
}
```

## UserHeroResponseDto

```java
@Data
@Builder
public class UserHeroResponseDto {

    private Long id;
    private Long userId;
    private HeroResponseDto hero;
    private int awakeningLevel;
}
```

---

# HeroMapper

```java
@Component
public class HeroMapper {

    public HeroResponseDto toDto(Hero hero) {

        if (hero == null) return null;

        return HeroResponseDto.builder()
                .id(hero.getId())
                .name(hero.getName())
                .imageSlug(hero.getImageSlug())
                .className(hero.getClassName())
                .classIconSlug(hero.getClassIconSlug())
                .rarity(hero.getRarity())
                .factions(
                        hero.getFactions() != null
                                ? List.copyOf(hero.getFactions())
                                : null
                )
                .lordFaction(hero.getLordFaction())
                .tags(
                        hero.getTags() != null
                                ? List.copyOf(hero.getTags())
                                : null
                )
                .build();
    }
}
```

---

# UserHeroMapper

```java
@Component
@RequiredArgsConstructor
public class UserHeroMapper {

    private final HeroMapper heroMapper;

    public UserHeroResponseDto toDto(UserHero userHero) {

        if (userHero == null) return null;

        return UserHeroResponseDto.builder()
                .id(userHero.getId())
                .userId(userHero.getUser().getId())
                .hero(heroMapper.toDto(userHero.getHero()))
                .awakeningLevel(userHero.getAwakeningLevel())
                .build();
    }
}
```

---

# Repositories

## HeroRepository

```java
public interface HeroRepository
        extends JpaRepository<Hero, Long> {

    boolean existsByName(String name);
}
```

## UserHeroRepository

```java
public interface UserHeroRepository
        extends JpaRepository<UserHero, Long> {

    List<UserHero> findByUserId(Long userId);

    Optional<UserHero> findByUserIdAndHeroId(
            Long userId,
            Long heroId
    );
}
```

---

# HeroController

```java
@RestController
@RequestMapping("/api/heroes")
@RequiredArgsConstructor
public class HeroController {

    private final HeroService heroService;

    @GetMapping
    public List getAllHeroes() {
        return heroService.getAllHeroes();
    }

    @GetMapping("/class/{className}")
    public List getHeroesByClass(
            @PathVariable String className
    ) {
        return heroService.findByClassName(className);
    }
}
```

---

# UserHeroController

```java
@RestController
@RequestMapping("/api/user-heroes")
@RequiredArgsConstructor
public class UserHeroController {

    private final UserHeroService userHeroService;

    @GetMapping("/{userId}")
    public ResponseEntity<List<UserHeroResponseDto>> getUserHeroes(
            @PathVariable Long userId
    ) {
        return ResponseEntity.ok(
                userHeroService.getUserHeroes(userId)
        );
    }

    @PostMapping("/{userId}/hero/{heroId}")
    public ResponseEntity<UserHeroResponseDto> toggleOrUpgradeHero(
            @PathVariable Long userId,
            @PathVariable Long heroId
    ) {
        return ResponseEntity.ok(
                userHeroService.toggleOrUpgradeHero(
                        userId,
                        heroId
                )
        );
    }

    @DeleteMapping("/{userId}/hero/{heroId}")
    public ResponseEntity<Void> removeUserHero(
            @PathVariable Long userId,
            @PathVariable Long heroId
    ) {
        userHeroService.removeUserHero(
                userId,
                heroId
        );

        return ResponseEntity.noContent().build();
    }
}
```

---

# HeroService

```java
@Service
@RequiredArgsConstructor
public class HeroService {

    private final HeroRepository heroRepository;
    private final HeroMapper heroMapper;

    @Transactional
    public List<HeroResponseDto> getAllHeroes() {

        return heroRepository.findAll()
                .stream()
                .map(heroMapper::toDto)
                .toList();
    }

    @Transactional
    public HeroResponseDto getHeroById(Long id) {

        return heroRepository.findById(id)
                .map(heroMapper::toDto)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "Hero not found with id: " + id
                        )
                );
    }

    @Transactional
    public List<HeroResponseDto> findByClassName(
            String className
    ) {

        return heroRepository.findAll()
                .stream()
                .filter(hero ->
                        hero.getClassName()
                                .equalsIgnoreCase(className)
                )
                .map(heroMapper::toDto)
                .toList();
    }
}
```

---

# UserHeroService

Поточна логіка:

```java
@Service
@RequiredArgsConstructor
public class UserHeroService {

    private final UserHeroRepository userHeroRepository;
    private final UserRepository userRepository;
    private final HeroRepository heroRepository;
    private final UserHeroMapper userHeroMapper;

    @Transactional
    public List findByUserId(Long userId) {

        return userHeroRepository.findByUserId(userId)
                .stream()
                .map(userHeroMapper::toDto)
                .toList();
    }

    @Transactional
    public UserHeroResponseDto toggleOrUpgradeHero(
            Long userId,
            Long heroId
    ) {

        UserHero userHero =
                userHeroRepository
                        .findByUserIdAndHeroId(userId, heroId)
                        .orElseGet(() -> {

                            User user =
                                    userRepository.findById(userId)
                                            .orElseThrow(() ->
                                                    new ResourceNotFoundException(
                                                            "User not found with id: "
                                                                    + userId
                                                    )
                                            );

                            Hero hero =
                                    heroRepository.findById(heroId)
                                            .orElseThrow(() ->
                                                    new ResourceNotFoundException(
                                                            "Hero not found with id: "
                                                                    + heroId
                                                    )
                                            );

                            return UserHero.builder()
                                    .user(user)
                                    .hero(hero)
                                    .awakeningLevel(0)
                                    .build();
                        });

        if (userHero.getId() != null) {

            if (userHero.getAwakeningLevel() < 5) {

                userHero.setAwakeningLevel(
                        userHero.getAwakeningLevel() + 1
                );

            } else {

                userHero.setAwakeningLevel(0);
            }
        }

        UserHero saved =
                userHeroRepository.save(userHero);

        return userHeroMapper.toDto(saved);
    }

    @Transactional
    public void removeUserHero(
            Long userId,
            Long heroId
    ) {

        userHeroRepository
                .findByUserIdAndHeroId(userId, heroId)
                .ifPresent(userHeroRepository::delete);
    }

    @Transactional
    public List getUserHeroes(Long userId) {
        return findByUserId(userId);
    }
}
```

---

# UserRoster

## Мультифракційність

Герой може належати до кількох фракцій.

Наприклад:

```json
{
    "factions": [
        "Watchguard Lord",
        "Supreme Arbiters"
    ]
}
```

UI може показувати одного героя в декількох секціях.

```text
Watchguard
 └── Lords
      └── Hero

Supreme Arbiters
 └── Hero
```

Одна картка може існувати в декількох UI-секціях.

---

# Awakening

Дублювання героя відбувається **тільки на рівні UI**.

Джерело стану:

```js
userHeroes[hero.id]
```

Модель:

```text
один hero.id
      ↓
один UserHero
      ↓
один awakeningLevel
      ↓
декілька UI-копій
```

Наприклад:

```text
Watchguard       → A3
Supreme Arbiters → A3
```

Натискання:

```text
Watchguard       → A4
Supreme Arbiters → A4
```

Backend при цьому не змінюється.

У БД залишається:

```text
user_id + hero_id
```

завдяки:

```java
@UniqueConstraint(
    columnNames = {"user_id", "hero_id"}
)
```

---

# Lord-фракції

Фракція:

```text
Watchguard Lord
```

нормалізується до:

```text
Watchguard
```

Так само:

```text
The North Throne Lord
→ The North Throne

Supreme Arbiters Lord
→ Supreme Arbiters
```

Герой може бути Lord однієї фракції і одночасно членом інших.

---

# DEMON SOLDIERS

## Статус

**Модуль Demon Soldiers реалізований.**

Готові:

- Entity
- Repository
- DTO
- Mapper
- Service
- Controller
- Flyway migration
- seed data
- фінальний `demons.json`

Demon Soldiers є **окремим каталогом**.

Вони **не є `UserHero`** і не мають прив'язки до користувача.

---

# DemonSoldier Entity

```java
@Entity
@Table(
        name = "demon_soldiers",
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "uk_demon_soldier_name",
                        columnNames = "name"
                ),
                @UniqueConstraint(
                        name = "uk_demon_soldier_image_slug",
                        columnNames = "image_slug"
                )
        }
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DemonSoldier {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 100)
    private String name;

    @Column(nullable = false, length = 20)
    private String rarity;

    @Column(nullable = false, length = 50)
    private String faction;

    @Column(nullable = false)
    @Builder.Default
    private int level = 1;

    @Column(
            name = "image_slug",
            nullable = false,
            unique = true,
            length = 100
    )
    private String imageSlug;
}
```

---

# DemonSoldier data model

```text
DemonSoldier
├── id
├── name
├── rarity
├── faction
├── level
└── imageSlug
```

---

# Demon Soldier Rarities

У грі для цього каталогу використовуються **тільки 3 rarity**:

```text
LEGENDARY
EPIC
RARE
```

Візуально:

```text
LEGENDARY → жовтий
EPIC      → фіолетовий
RARE      → синій
```

**Mythic не використовується.**

---

# Demon Soldier Level

Початковий рівень:

```text
1
```

Level належить безпосередньо `DemonSoldier`.

На поточному етапі:

- level-up механіка не реалізована;
- UserDemonSoldier не існує;
- рівень не залежить від користувача.

---

# DemonSoldier DTO

```java
@Data
@Builder
public class DemonSoldierResponse {

    private Long id;
    private String name;
    private String rarity;
    private String faction;
    private int level;
    private String imageSlug;
}
```

---

# DemonSoldierMapper

```java
@Component
public class DemonSoldierMapper {

    public DemonSoldierResponse toDto(
            DemonSoldier soldier
    ) {

        if (soldier == null) {
            return null;
        }

        return DemonSoldierResponse.builder()
                .id(soldier.getId())
                .name(soldier.getName())
                .rarity(soldier.getRarity())
                .faction(soldier.getFaction())
                .level(soldier.getLevel())
                .imageSlug(soldier.getImageSlug())
                .build();
    }
}
```

---

# DemonSoldierRepository

```java
public interface DemonSoldierRepository
        extends JpaRepository<DemonSoldier, Long> {

    boolean existsByName(String name);
}
```

---

# DemonSoldierService

```java
@Service
@RequiredArgsConstructor
public class DemonSoldierService {

    private final DemonSoldierRepository demonSoldierRepository;
    private final DemonSoldierMapper demonSoldierMapper;

    @Transactional(readOnly = true)
    public List<DemonSoldierResponse> getAllDemonSoldiers() {

        return demonSoldierRepository.findAll()
                .stream()
                .map(demonSoldierMapper::toDto)
                .toList();
    }

    @Transactional(readOnly = true)
    public DemonSoldierResponse getDemonSoldierById(
            Long id
    ) {

        return demonSoldierRepository.findById(id)
                .map(demonSoldierMapper::toDto)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "Demon Soldier not found with id: " + id
                        )
                );
    }
}
```

---

# DemonSoldierController

Backend endpoints:

```http
GET /api/demon-soldiers
GET /api/demon-soldiers/{id}
```

Controller:

```java
@RestController
@RequestMapping("/api/demon-soldiers")
@RequiredArgsConstructor
public class DemonSoldierController {

    private final DemonSoldierService demonSoldierService;

    @GetMapping
    public ResponseEntity<List<DemonSoldierResponse>> getAll() {

        return ResponseEntity.ok(
                demonSoldierService.getAllDemonSoldiers()
        );
    }

    @GetMapping("/{id}")
    public ResponseEntity<DemonSoldierResponse> getById(
            @PathVariable Long id
    ) {

        return ResponseEntity.ok(
                demonSoldierService.getDemonSoldierById(id)
        );
    }
}
```

Frontend endpoints через Axios:

```js
api.get('/demon-soldiers')
api.get(`/demon-soldiers/${id}`)
```

---

# Demon Soldiers Database

Таблиця:

```text
demon_soldiers
```

Поля:

```text
id
name
rarity
faction
level
image_slug
```

Constraints:

```text
name UNIQUE
image_slug UNIQUE
```

---

# Demon Soldiers Flyway

Flyway migration створена та виконана.

Migration створює:

```sql
CREATE TABLE demon_soldiers (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    rarity VARCHAR(20) NOT NULL,
    faction VARCHAR(50) NOT NULL,
    level INTEGER NOT NULL DEFAULT 1,
    image_slug VARCHAR(100) NOT NULL,

    CONSTRAINT uk_demon_soldier_name
        UNIQUE (name),

    CONSTRAINT uk_demon_soldier_image_slug
        UNIQUE (image_slug)
);
```

Migration також містить seed для **всіх 61 Demon Soldier**.

---

# Demon Soldiers — final data

Усього:

```text
61 Demon Soldiers
```

## Frostborne — 8

```text
Frost Canid
Frost Guardian
Frostbourne Scholar
Frozen Cleric
Frozen Drifter
Frozen Raider
Glacius (Demon Soldier)
Ice Vermin
```

## Chaos — 8

```text
Bloodmend Rats
Chaos Shaman
Doomripper
Emberfire Templar
Grotesque Fiend
High-order Abyssal Beholder
Infernal Cleric
Slaughter
```

## Bloodspring — 8

```text
Baron Salem
Batwings Banshee
Blasting Corpse
Blood Hexer
Countess Mariath
Specter Skeleton Archer
Tormented Banshee
Twisted Sycophant
```

## Stonekin — 7

```text
Boulder Ravager
Garnet Guard
Giant Golem
Golden Guard
Ruinstone Drifter
Smasher Guard
Wasteland Titan (Demon Soldier)
```

## Neutral — 30

```text
Adag's Follower
Axe Slaughterer
Book Keeper
Carrion Hound
Elite Skeleton Archer
Fallen Reaper
Fallen Templar
Ghoul Hound
Imperial Pharaoh Guard
Knight of Destruction
Lightning Guard
Lizardfly Imago
Maw (Demon Soldier)
Murkling Menace
Necromancer
Pharaoh's Guard
Scalekin Champion
Scalekin Mage
Scalekin Shaman
Scalekin Warrior
Scourge
Shadowcaster
Skeleton Guardian
Small Arachnid
Soulbone Archer
Stitched Carrion
Suicide
The Fool
Uncommon Destroyer
White Tower's Scholar
```

---

# Final Demon Soldier Rarity Rules

Фінальний JSON використовує:

```text
LEGENDARY
EPIC
RARE
```

Всі записи повинні використовувати uppercase.

Зокрема:

```text
Scalekin Mage → RARE
```

а не:

```text
Rare
```

---

# Demon Soldier Image System

Зовнішні image URL **більше не використовуються**.

Початковий JSON мав:

```json
{
    "name": "...",
    "url": "...",
    "faction": "..."
}
```

`url` був видалений.

Фінальна модель використовує:

```text
imageSlug
```

Наприклад:

```text
Frost Canid
→ frost-canid
```

```text
Glacius (Demon Soldier)
→ glacius-demon-soldier
```

```text
High-order Abyssal Beholder
→ high-order-abyssal-beholder
```

```text
Adag's Follower
→ adags-follower
```

```text
Pharaoh's Guard
→ pharaohs-guard
```

```text
White Tower's Scholar
→ white-towers-scholar
```

---

# Final `demons.json`

Файл був підготовлений із такими полями:

```json
{
    "name": "Frost Canid",
    "faction": "Frostborne Demon Soldiers",
    "rarity": "LEGENDARY"
}
```

`url` повністю видалений.

Фракції:

```text
Frostborne Demon Soldiers
Chaos Demon Soldiers
Bloodspring Demon Soldiers
Stonekin Demon Soldiers
Neutral Demon Soldiers
```

---

# Demon JSON preprocessing script

Для підготовки JSON використовувався Node.js script:

```js
const fs = require("node:fs/promises");

const FILE = "./demons.json";

async function main() {
    const data = JSON.parse(
        await fs.readFile(FILE, "utf8")
    );

    for (const item of data) {

        if (typeof item.faction === "string") {
            item.faction = item.faction.replace(/\[\]$/, "");
        }

        delete item.url;

        item.rarity = "";
    }

    await fs.writeFile(
        FILE,
        JSON.stringify(data, null, 4),
        "utf8"
    );

    console.log("✅ Готово! demons.json оновлено.");
}

main().catch(console.error);
```

Після цього rarity були заповнені вручну на основі скріншотів гри.

---

# Current Architecture Rule

Не ламати існуючу модель `UserHero`.

Ключовий ідентифікатор стану героя:

```text
hero.id
```

Фракції керують **відображенням**, а не володінням.

```text
Hero
├── factions → де показувати
├── lordFaction → де він Lord
└── id → який це герой

UserHero
├── user
├── hero
└── awakeningLevel → стан героя користувача
```

Demon Soldiers зараз є окремим каталогом:

```text
DemonSoldier
├── id
├── name
├── rarity
├── faction
├── level
└── imageSlug
```

**Не створювати `UserDemonSoldier`, якщо це окремо не буде визначено в майбутньому ТЗ.**

---

# Current Known Issues

## 1. UserRoster `/api` prefix

**Виправлено.**

Axios вже має:

```text
/api
```

Frontend використовує endpoint без `/api`.

---

## 2. HeroResponseDto image field

Backend:

```java
imageSlug
```

Frontend:

```js
hero.imageSlug
```

Не використовувати:

```js
hero.imageUrl
```

---

## 3. GuildPage

Frontend очікує members endpoints, яких backend поки не реалізує.

Потребує окремої роботи.

---

## 4. CORS

Потрібно переконатися, що `PATCH` присутній у дозволених CORS methods.

---

## 5. Guild creator

Поточне створення guild не прикріплює guild до creator.

Потребує окремого виправлення.

---

## 6. UserProfileResponse

`UserProfileResponse` наразі не містить:

```text
inviteCode
```

Потребує окремого виправлення.

---

# Share Roster

## Статус

**Відкладено до моменту після деплою.**

Не реалізовувати зараз.

---

# Share Roster — майбутній план

Публічне посилання:

```text
/shared/{token}
```

Не:

```text
/shared/{userId}
```

щоб не відкривати user ID та не дозволяти простий перебір користувачів.

Передбачувана сутність:

```text
RosterShare
```

з:

```text
id
user_id
token
created_at
expires_at
revoked
```

Публічний endpoint:

```http
GET /roster-shares/{token}
```

Власник створює/отримує share token через авторизований endpoint.

Публічний endpoint повертає read-only:

```text
heroes
userHeroes / awakeningLevel
```

UI використовує ту саму логіку фракцій та awakening.

---

# Share Roster Principle

Share-функція не повинна створювати копії `UserHero`.

Модель:

```text
User
 ↓
UserHero
 ↓
Hero
```

Share лише дає публічний спосіб прочитати актуальний ростер.

Після зміни власником:

```text
Hero A → A3
Hero B → A1
Hero C → видалений
```

старе share-посилання повинно показувати актуальний стан.

---

# Share-функція — борг

Після деплою:

```text
Create share link
Copy share link
Open public roster
Read-only public roster
Revoke share link
Generate new share link
```

Поки ця функція **не входить у поточний scope**.

---

# Current Project Status

Реалізовано:

```text
Authentication
    ↓
Users
    ↓
Heroes
    ↓
User Heroes
    ↓
UserRoster
    ↓
Guild базова логіка
    ↓
Demon Soldiers
```

### Demon Soldiers

```text
✅ JSON
✅ 61 soldiers
✅ 3 rarities
✅ factions
✅ initial level = 1
✅ imageSlug
✅ Entity
✅ Repository
✅ DTO
✅ Mapper
✅ Service
✅ Controller
✅ Flyway table
✅ Flyway seed
```

### Поки не реалізовано

```text
❌ UserDemonSoldier
❌ Demon Soldier ownership
❌ Demon Soldier upgrade mechanics
❌ Share Roster
❌ Guild members API
❌ Guild creator fix
❌ inviteCode у UserProfileResponse
```

Це є **актуальний baseline контексту проєкту** для подальшої роботи.