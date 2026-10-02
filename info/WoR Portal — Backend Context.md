# WoR Portal

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

```text
localStorage["token"]
```

Header:

```text
Authorization: Bearer <token>
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

---

# User Heroes

```http
GET /user-heroes/{userId}
POST /user-heroes/{userId}/hero/{heroId}
DELETE /user-heroes/{userId}/hero/{heroId}
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
@Table(name = "user_heroes", uniqueConstraints = {
        @UniqueConstraint(columnNames = {"user_id", "hero_id"})
})
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
        return heroRepository.findAll().stream()
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
        return heroRepository.findAll().stream()
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
        return userHeroRepository.findByUserId(userId).stream()
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

# Поточна логіка UserRoster

## Мультифракційність

Герой може належати до **кількох фракцій одночасно**.

Наприклад:

```json
{
  "factions": [
    "Watchguard Lord",
    "Supreme Arbiters"
  ]
}
```

Такий герой повинен відображатися:

```text
Watchguard
  └── Lords
       └── Hero

Supreme Arbiters
  └── Hero
```

Одна й та сама картка може бути показана в декількох секціях.

---

# Важливе правило для awakening

Дублювання героя відбувається **тільки на рівні UI**.

Джерелом стану залишається:

```js
userHeroes[hero.id]
```

Тобто:

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

Якщо натиснути на героя в `Watchguard`:

```text
Watchguard       → A4
Supreme Arbiters → A4
```

Логіка backend при цьому не змінюється.

У БД залишається один запис:

```text
user_id + hero_id
```

за рахунок:

```java
@UniqueConstraint(
    columnNames = {"user_id", "hero_id"}
)
```

---

# Lord-фракції

Фракція виду:

```text
Watchguard Lord
```

нормалізується до:

```text
Watchguard
```

Те саме:

```text
The North Throne Lord
→ The North Throne

Supreme Arbiters Lord
→ Supreme Arbiters
```

Герой може бути Lord для однієї фракції та одночасно членом інших фракцій.

---

# Frontend API правило

Axios вже має:

```text
baseURL = http://localhost:8080/api
```

Тому frontend НЕ повинен додавати `/api`.

Правильно:

```js
api.get('/heroes')
api.get(`/user-heroes/${userId}`)
api.post(`/user-heroes/${userId}/hero/${heroId}`)
api.delete(`/user-heroes/${userId}/hero/${heroId}`)
```

Неправильно:

```js
api.get('/api/heroes')
```

---

# Current Known Issues

## 1. UserRoster `/api` prefix

Виправлено.

Axios вже має `/api`, тому frontend використовує тільки endpoint без `/api`.

---

## 2. HeroResponseDto image field

Backend використовує:

```java
imageSlug
```

Frontend повинен використовувати:

```js
hero.imageSlug
```

а не:

```js
hero.imageUrl
```

---

## 3. GuildPage

Frontend очікує members endpoints, яких backend поки не реалізує.

Потребує окремої роботи.

---

## 4. CORS

Потрібно переконатися, що PATCH присутній у дозволених CORS methods.

---

## 5. Guild creator

Поточне створення guild не прикріплює guild до creator.

Потребує окремого виправлення.

---

## 6. UserProfileResponse

`UserProfileResponse` наразі не містить `inviteCode`.

Потребує окремого виправлення.

---

# Нове: Share Roster

## Статус

**Відкладено до моменту після деплою.**

Не реалізовувати зараз.

---

# План Share Roster на майбутнє

Публічне посилання має виглядати приблизно так:

```text
/shared/{token}
```

а не:

```text
/shared/{userId}
```

щоб не відкривати user ID та не дозволяти простий перебір користувачів.

---

## Передбачувана архітектура

Окрема сутність, наприклад:

```text
RosterShare
```

з даними:

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

# Принцип Share Roster

Share-функція не повинна створювати копії `UserHero`.

Модель має залишатися:

```text
User
  ↓
UserHero
  ↓
Hero
```

Share лише дає публічний спосіб прочитати актуальний ростер.

Тому після зміни власником ростера:

```text
Hero A → A3
Hero B → A1
Hero C → видалений
```

старе share-посилання повинно показувати актуальний стан.

---

# Share-функція — борг

Після деплою реалізувати:

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

# Current Architecture Rule

Не ламати існуючу модель `UserHero`.

Ключовий ідентифікатор стану героя:

```text
hero.id
```

Фракції керують **відображенням**, а не володінням.

Тобто:

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