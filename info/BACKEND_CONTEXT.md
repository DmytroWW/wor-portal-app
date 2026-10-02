# WoR Portal

## Stack
Frontend:
- React
- Vite
- Tailwind
- Axios

Backend:
- Spring Boot
- Spring Security
- JWT
- JPA
- PostgreSQL
- Flyway

## URLs

Frontend:
http://localhost:5173

Backend:
http://localhost:8080

API prefix:
/api

## Axios

baseURL:
http://localhost:8080/api

JWT:
localStorage["token"]

Header:
Authorization: Bearer <token>

## Auth

POST /auth/login
POST /auth/register

## Users

GET /users/me

## Heroes

GET /heroes
GET /heroes/class/{className}

## User Heroes

GET /user-heroes/{userId}
POST /user-heroes/{userId}/hero/{heroId}
DELETE /user-heroes/{userId}/hero/{heroId}

## Guild

POST /guilds/create
POST /guilds/join

## Roles

ADMIN
LEADER
OFFICER
MEMBER

## Current known issues

1. UserRoster was using /api prefix twice.
2. HeroResponseDto uses imageSlug, frontend expected imageUrl.
3. GuildPage expects members endpoints that backend does not yet implement.
4. PATCH is missing from CORS allowed methods.
5. Creating guild does not currently attach guild to creator.
6. UserProfileResponse does not contain inviteCode.

## Important architecture rule

Because axios baseURL already ends with /api,
frontend requests must NOT start with /api.

Correct:
api.get('/heroes')

Wrong:
api.get('/api/heroes')